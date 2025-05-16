module Forecasts
  class ForecastDecorator
    def initialize(forecast)
      @location = forecast[:location]
      @current = forecast[:current]
      @forecast = forecast[:forecast]
      @cached_response = forecast[:cached_response]
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
