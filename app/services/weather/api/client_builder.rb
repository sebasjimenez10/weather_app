module Weather
  module API
    # ClientBuilder is responsible for building the appropriate API client
    # based on the provided API symbol.
    # Currently supports only the WeatherAPI client.
    class ClientBuilder
      class << self
        # Builds the appropriate client based on the provided name.
        #
        # @param [Symbol] name The client name
        # @return [Weather::API::ClientBase] any subclass of Weather::API::ClientBase
        # @raise [RuntimeError] if the client name is unsupported
        def build_client(name:)
          case name
          when :weather_api
            Weather::API::WeatherAPI::Client.new
          else
            Rails.logger.error("Unsupported weather client: #{name}")
            raise "Unsupported client"
          end
        end
      end
    end
  end
end
