module Weather
  module API
    module WeatherAPI
      # Client is responsible for interacting with the Weather API.
      # It uses HTTParty to make HTTP requests and fetch weather forecast data.
      # It inherits from the ClientBase module, which provides a base structure for API clients.
      class Client < ClientBase
        base_uri "https://api.weatherapi.com"
        default_params days: 5, aqi: "no", alerts: "no"

        # Holds the authentication details for the Weather API.
        attr_accessor :auth

        # Initializes the WeatherAPI client with the provided API key.
        # The API key is fetched from the Rails credentials based on the current environment.
        #
        # @param [String] Optional key The API key for the Weather API
        def initialize(key: api_key, client: self.class)
          @auth = { key: key }
          @client = client
        end

        # Fetches the weather forecast for the given a query string.
        #
        # @param [String] query open format address string to fetch the forecast for
        # @return [Weather::API::WeatherAPI::Response] The parsed response object containing forecast data
        # @raise [HTTParty::Error] if the request fails
        # @raise [JSON::ParserError] if the response is not valid JSON
        def forecast(query)
          Rails.logger.debug("Fetching forecast for query: #{query}")

          options = { q: query }.merge!(auth)
          response = @client.get("/v1/forecast.json", query: options, format: :plain)
          return Response.new(response) if response.success?

          Rails.logger.error("Error fetching forecast: #{response.code} - #{response.message}")
          raise HTTParty::Error, "Failed to fetch forecast: #{response.message}"
        end

        private

        # Fetches the API key from the Rails credentials based on the current environment.
        #
        # @return [String] The API key for the Weather API
        def api_key
          Rails.application.credentials[Rails.env].weather_api_key
        end
      end
    end
  end
end
