module Weather
  module API
    module WeatherAPI
      # Client is responsible for interacting with the Weather API.
      # It uses HTTParty to make HTTP requests and fetch weather forecast data.
      # The client is a singleton, ensuring that only one instance is used throughout the application.
      # It includes the ClientBase module, which provides a base structure for API clients.
      # The client is initialized with an API key, which is stored in the Rails credentials.
      class Client < ClientBase
        base_uri "https://api.weatherapi.com"
        default_params days: 5, aqi: "no", alerts: "no"

        # Initializes the WeatherAPI client with the provided API key.
        # The API key is fetched from the Rails credentials based on the current environment.
        # If no key is provided, it defaults to the one in the credentials.
        #
        # @param [String] Optional key The API key for the Weather API
        def initialize(key = api_key)
          @auth = { key: key }
        end

        # Fetches the weather forecast for the given zip code.
        # It constructs the query parameters with the zip code and authentication key.
        # The response is parsed and returned as a Response object.
        #
        # @param [String] zip_code The zip code for which to fetch the forecast
        # @return [Weather::API::Response] The parsed response object containing forecast data
        # @raise [HTTParty::Error] if the request fails
        # @raise [JSON::ParserError] if the response is not valid JSON
        def forecast(zip_code)
          options = { q: zip_code }.merge!(@auth)

          self.class.get("/v1/forecast.json", query: options, format: :plain).then do |json_response|
            Response.new(json_response)
          end
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
