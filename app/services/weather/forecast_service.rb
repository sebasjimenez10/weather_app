module Weather
  class ForecastService
    class << self
      # ForecastService::forecast
      # @param [StreetAddress::US] :address The parsed address
      # @return [Hash] with location, current, forecast and cached_response indicator
      def forecast(address:, builder: API::ClientBuilder)
        client = builder.build_client(name: :weather_api)

        cached_response = true
        response = Rails.cache.fetch(address.postal_code) do
          cached_response = false
          client.forecast(address.postal_code)
        end

        {
          location: response.data.location,
          current: response.data.current,
          forecast: response.data.forecast,
          cached_response: cached_response
        }
      end
    end
  end
end
