module Weather
  module WeatherAPI
    class Client < ClientBase
      base_uri "https://api.weatherapi.com"
      default_params days: 5, aqi: "no", alerts: "no"

      def initialize(key = api_key)
        @auth = { key: key }
      end

      def forecast(zip_code)
        options = { q: zip_code }.merge!(@auth)

        json_response = self.class.get("/v1/forecast.json", query: options, format: :plain)
        Response.new(json_response)
      end

      private

      def api_key
        Rails.application.credentials[Rails.env].weather_api_key
      end
    end
  end
end
