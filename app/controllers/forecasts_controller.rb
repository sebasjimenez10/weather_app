class ForecastsController < ApplicationController
  def index
  end

  def show
    forecast = ForecastAddressForm.new(forecast_params)

    if forecast.valid?
      address = forecast.to_street_address

      Weather::ForecastService.forecast(address: address).tap do |response|
        @forecast_decorator = Forecasts::ForecastDecorator.new(response)
      end
    else
      redirect_to forecasts_path, flash: { alert: "Please enter a valid address." }
    end
  end

  private

  def forecast_params
    { address: params[:address] }
  end
end
