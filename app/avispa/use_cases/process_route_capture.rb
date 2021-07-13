module UseCases
  # Connects to Skyscanner and asks information about a route
  class ProcessRouteCapture < Base
    def initialize(capture:) # rubocop:disable Lint/UselessMethodDefinition
      super
    end

    def run_validations
      error(message: 'CAPTURE_BLANK', producer: self) if @capture.blank?
    end

    def prepare
      @payload = @capture.payload
      @carriers = @payload[:carriers].map { |x| [x[:carrier_id], x[:name]] }.to_h
      @places = @payload[:places].map { |p| [p[:place_id], p[:skyscanner_code]] }.to_h
      @quotes = @payload[:quotes]
    end

    def run
      @quotes.each do |quote|
        quote => { min_price: price,
                   outbound_leg: {carrier_ids:, origin_id:, destination_id:, departure_date: departs_at } }
        carrier = @carriers[carrier_ids.first]
        from = @places[origin_id]
        to = @places[destination_id]

        @capture.route_options.create(from: from, to: to,
                                      airline_ref: carrier, price: price,
                                      departs_at: departs_at,
                                      raw_payload: quote)
      end
    end
  end
end
