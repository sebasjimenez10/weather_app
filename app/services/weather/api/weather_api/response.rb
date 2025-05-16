require "ostruct"

module Weather
  module API
    module WeatherAPI
      class Response
        attr_accessor :data

        def initialize(json)
          @data = JSON.parse(json, object_class: OpenStruct)
        end
      end
    end
  end
end
