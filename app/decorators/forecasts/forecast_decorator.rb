module Forecasts
  # Decorator for Forecasts response data.
  class ForecastDecorator < DecoratorBase
    # Initializes the ForecastDecorator with the forecast data.
    # It extracts the location, current weather, and forecast data from the response.
    #
    # @param [Forecasts::ForecastResult] forecast The forecast result object
    # @return [Forecasts::ForecastDecorator] The initialized ForecastDecorator object
    def initialize(forecast)
      response = forecast.response
      cached_response = forecast.cached_response

      @location = response.location
      @current = response.current
      @forecast = response.forecast
      @cached_response = cached_response
    end

    def city
      @location.name
    end

    def state
      @location.region
    end

    def country
      @location.country
    end

    def localtime
      @location.localtime
    end

    def cached_response
      @cached_response
    end

    def current_temp_c
      @current.temp_c
    end

    def current_temp_f
      @current.temp_f
    end

    def condition_text
      @current.condition.text
    end

    def condition_icon
      @current.condition.icon
    end

    def forecastdays
      @forecast.forecastday
    end
  end
end
