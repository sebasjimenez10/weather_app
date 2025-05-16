# ForeecastResult class to handle the response from the ForecastService.
# It encapsulates the response and cached_response attributes.
#
# @attr_reader [Weather::API::Response] :response The response object containing forecast data
# @attr_reader [Boolean] :cached_response Indicates if the response was cached
#
class ForecastResult
  attr_reader :response, :cached_response

  def initialize(response:, cached_response:)
    @response = response
    @cached_response = cached_response
  end
end
