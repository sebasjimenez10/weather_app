module Forecasts
  # Decorator for Forecasts response data.
  class ForecastDecorator < DecoratorBase
    # Initializes the ForecastDecorator with the forecast data.
    # It extracts the location, current weather, and forecast data from the response.
    #
    # @param [Forecasts::ForecastResult] forecast The forecast result object
    #   - result [Weather::API::WeatherAPI::Response]
    #   - cached_response [Boolean]
    # @return [Forecasts::ForecastDecorator] The initialized ForecastDecorator object
    def initialize(forecast)
      result = forecast.result
      cached_response = forecast.cached_response

      @location = result.location
      @current = result.current
      @forecast = result.forecast
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
      @location.localtime.to_datetime.strftime("%A, %B %d, %Y")
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

    def friendly_time(time)
      time.to_datetime.strftime("%I:%M %p")
    end

    def friendly_date(date)
      date.to_datetime.strftime("%B %d, %Y")
    end
  end
end
