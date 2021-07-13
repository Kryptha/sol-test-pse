module UseCases
  # Connects to Skyscanner and asks information about a route
  # Uses RapidAPI to do so
  # https://rapidapi.com/skyscanner/api/skyscanner-flight-search/
  class LoadIncomingRoutes < Base
    require 'uri'
    require 'net/http'
    require 'openssl'

    #ENV Change to direct Rapidapi_key. ENV problems of configuration with diferents PC's
    RAPIDAPI_KEY = ENV.fetch('RAPIDAPI_KEY', 'no-radip-api-key-check-dotenv')
    def initialize(from:, to:) # rubocop:disable Lint/UselessMethodDefinition
      super
    end

    def run_validations
      error(message: 'DESTINATION_EQUALS_ORIGIN', producer: self) if @from == @to
    end

    def prepare
      @url = URI("https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com/apiservices/browseroutes/v1.0/CL/USD/es-CL/#{@from}-sky/#{@to}-sky/anytime/")
      @http = Net::HTTP.new(@url.host, @url.port)
      @http.use_ssl = true
      @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end

    def run
      request = Net::HTTP::Get.new(@url)
      request['x-rapidapi-key'] = 'bd5f9db2abmsh2a2242bbb021c96p1729ddjsn5856cc35375e'
      request['x-rapidapi-host'] = 'skyscanner-skyscanner-flight-search-v1.p.rapidapi.com'
      byebug
      response = @http.request(request)
      payload = response.read_body

      RouteCapture.create from: @from, to: @to, raw_payload: payload
    end
  end
end
