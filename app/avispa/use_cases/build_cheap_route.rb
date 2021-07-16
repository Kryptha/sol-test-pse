module UseCases
  # Shows the cheapest alternative for every origin
  class BuildCheapRoute < Base
  
    def run_validations; end

    def prepare
      @routes = ::RouteOption.in(6.hours)
      @origins = @routes.distinct(:from).pluck(:from)
      @destinations = @routes.distinct(:to).pluck(:to)
      @airlines = @routes.distinct(:airline_ref).pluck(:airline_ref)
      @travel_mtx = {}
    end

    def run
      possible_routes.each do |from, to, airline|
        leg = @routes.origin(from).destination(to).airline(airline).cheaper.first
        @travel_mtx["#{from}->#{to}"] = leg
      end

      @travel_mtx.each_value do |leg|
        #Ticket: Add a departs_art 
        ::CheapRoute.create(from: leg.from, to: leg.to, price: leg.price, 
          airline: leg.airline_ref, departs_at: leg.departs_at)
      end
    end

    def possible_routes
      routes = []
      @origins.each do |from|
        @destinations.each do |to|
          @airlines.each do |airline|
            routes << [from, to, airline] if valid_triple? from, to, airline
          end
        end
      end
      routes
    end

    def valid_triple?(from, to, airline)
      @routes.where(from: from, to: to, airline_ref:  airline).present?
    end
  end
end
