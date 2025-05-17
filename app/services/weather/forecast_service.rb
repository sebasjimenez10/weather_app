module Weather
  # ForecastService is responsible for fetching weather forecast data
  class ForecastService
    class << self
      # Performs a weather forecast lookup for the given address.
      # Uses the Weather API client to fetch the forecast data.
      #
      # @param [StreetAddress::US] :address The parsed address
      # @param [Symbol] :client The client to use for the request
      # @return [ForecastResult] with result and cached_response indicator
      #   - result [Weather::API::WeatherAPI::Response] The response object containing forecast data
      #   - cached_response [Boolean] Indicates if the response was cached
      def forecast(address:, api: :weather_api)
        client = build_client_for(api)

        cached_response = check_cache_existence(address)
        forecast = retrieve_forecast(address, client)

        ForecastResult.new(result: forecast, cached_response: cached_response)
      end

      private

      # Builds the appropriate client based on the provided API symbol.
      # Supported APIs: [:weather_api]
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
      # @return [Weather::API::WeatherAPI::Response] The response object containing forecast data
      #   - data [OpenStruct] The forecast data
      def retrieve_forecast(address, client)
        if address.postal_code.blank?
          Rails.logger.info("[ForecastService][Cache miss] zip code missing #{address.to_s.strip}")
          return client.forecast(address.to_s.strip)
        end

        Rails.cache.fetch(address.postal_code, expires_in: 30.minutes) do
          Rails.logger.info("[ForecastService][Cache miss] Fetching forecast for #{address.postal_code}")
          client.forecast(address.postal_code)
        end
      end

      # Checks if the forecast data for the given address is already cached.
      # Returns true if cached, false otherwise.
      #
      # @param [StreetAddress::US] address The parsed address
      # @return [Boolean] true if cached, false otherwise
      def check_cache_existence(address)
        return false if address.postal_code.blank?

        cache_exists = Rails.cache.exist?(address.postal_code)

        if cache_exists
          Rails.logger.info("[ForecastService][Cache hit] Fetching forecast for #{address.postal_code}")
        end

        cache_exists
      end
    end

    # ForecastResult class to handle the response from the ForecastService.
    # It encapsulates the result and cached_response attributes.
    #
    # @attr_reader [Weather::API::WeatherAPI::Response] :result The result object containing forecast data
    # @attr_reader [Boolean] :cached_response Indicates if the response was cached
    #
    class ForecastResult
      attr_reader :result, :cached_response

      def initialize(result:, cached_response:)
        @result = result
        @cached_response = cached_response
      end
    end
  end
end
