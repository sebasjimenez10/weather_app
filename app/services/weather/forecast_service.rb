module Weather
  class ForecastService
    class << self
      def forecast(address:, builder: API::ClientBuilder)
      end

      def client(builder)
        @client ||= builder.build_client(name: :weather_api)
      end
    end
  end
end
