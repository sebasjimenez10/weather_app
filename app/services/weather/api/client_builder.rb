module Weather
  module API
    class ClientBuilder
      class << self
        def build_client(name:)
          case name
          when :weather_api
            Weather::API::WeatherAPI::Client.instance
          else
            raise "Unsupported client"
          end
        end
      end
    end
  end
end
