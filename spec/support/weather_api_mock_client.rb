require "ostruct"

module Weather
  module API
    module WeatherAPI
      class MockClient
        def initialize(success: true)
          @success = success
        end

        def get(*)
          body = File.read(Rails.root.join("spec", "fixtures", "weather_api_response.json"))

          OpenStruct.new(
            code: @success ? 200 : 500,
            message: @success ? "OK" : "Internal Server Error",
            success?: @success,
            to_str: @success ? body : nil,
          )
        end
      end
    end
  end
end
