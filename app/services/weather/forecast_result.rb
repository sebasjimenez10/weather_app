# ForecastResult class to handle the response from the ForecastService.
# It encapsulates the result and cached_response attributes.
#
# @attr_reader [Weather::API::WeatherAPI::Response] :result The result object containing forecast data
# @attr_reader [Boolean] :cached_response Indicates if the response was cached
#
module Weather
  class ForecastResult
    attr_reader :result, :cached_response

    def initialize(result:, cached_response:)
      @result = result
      @cached_response = cached_response
    end
  end
end
