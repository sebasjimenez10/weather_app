module Weather
  module API
    module WeatherAPI
      class MockClient
        def get(*)
          File.read(Rails.root.join("spec", "fixtures", "weather_api_response.json"))
        end
      end
    end
  end
end
