module UseCases
  # Shows the cheapest alternative for every origin
  class BuildCheapRoute < Base
  
    def run_validations; end

    def prepare
      @routes = ::RouteOption.in(6.hours)
      @origins = @routes.distinct(:from).pluck(:from)
      @destinations = @routes.distinct(:to).pluck(:to)
      @travel_mtx = {}
    end

    def run
      possible_routes.each do |from, to|
        leg = @routes.origin(from).destination(to).cheaper.first
        @travel_mtx["#{from}->#{to}"] = leg
      end

      @travel_mtx.each_value do |leg|
        ::CheapRoute.create(from: leg.from, to: leg.to, price: leg.price, airline: leg.airline_ref)
      end
    end

    def possible_routes
      routes = []
      @origins.each do |from|
        @destinations.each do |to|
          routes << [from, to] if valid_tuple? from, to
        end
      end
      routes
    end

    def valid_tuple?(from, to)
      @routes.where(from: from, to: to).present?
    end
  end
end
