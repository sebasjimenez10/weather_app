require "ostruct"

module Weather
  module API
    module WeatherAPI
      # Response is responsible for parsing the JSON response from the Weather API.
      # It uses OpenStruct to allow for easy access to the JSON data as properties.
      # @see Weather::API::WeatherAPI::Client
      class Response
        attr_accessor :data

        # Initializes the Response object with the JSON response from the Weather API.
        #
        # @param [String] json The JSON response from the Weather API
        # @return [OpenStruct] The parsed JSON data
        # @raise [JSON::ParserError] if the JSON is invalid
        def initialize(json)
          @data = JSON.parse(json, object_class: OpenStruct)
        end

        # Provides access to the location data from the JSON response.
        #
        # @return [OpenStruct] The location data
        def location
          @data.location
        end

        # Provides access to the current weather data from the JSON response.
        #
        # @return [OpenStruct] The current weather data
        def current
          @data.current
        end

        # Provides access to the forecast data from the JSON response.
        #
        # @return [OpenStruct] The forecast data
        def forecast
          @data.forecast
        end
      end
    end
  end
end
