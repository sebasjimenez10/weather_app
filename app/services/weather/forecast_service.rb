module Weather
  # ForecastService is responsible for fetching weather forecast data
  class ForecastService
    class << self
      # Performs a weather forecast lookup for the given address.
      # Uses the Weather API client to fetch the forecast data.
      #
      # @param [StreetAddress::US] :address The parsed address
      # @param [Symbol] :client The client to use for the request
      # @return [Hash] with location, current, forecast and cached_response indicator
      def forecast(address:, api: :weather_api)
        client = build_client_for(api)

        cached_response = check_cache_existence(address)
        response = retrieve_forecast(address, client)

        ForecastResult.new(response: response, cached_response: cached_response)
      end

      private

      # Builds the appropriate client based on the provided API symbol.
      # Supports [:weather_api]
      #
      # @param [Symbol] api The API symbol
      # @return [Weather::API::WeatherAPI::ClientBase] any subclass of Weather::API::ClientBase
      def build_client_for(api)
        API::ClientBuilder.build_client(name: api)
      end

      # Retrieves the forecast data for the given address using the provided client.
      # Caches the response for 30 minutes.
      #
      # @param [StreetAddress::US] address The parsed address
      # @param [Weather::API::ClientBase] client The client to use for the request
      # @return [Weather::API::Response] The response object containing forecast data
      def retrieve_forecast(address, client)
        Rails.cache.fetch(address.postal_code, expires_in: 30.minutes) do
          client.forecast(address.postal_code)
        end
      end

      # Checks if the forecast data for the given address is already cached.
      # Returns true if cached, false otherwise.
      #
      # @param [StreetAddress::US] address The parsed address
      # @return [Boolean] true if cached, false otherwise
      def check_cache_existence(address)
        Rails.cache.exist?(address.postal_code)
      end
    end
  end
end
