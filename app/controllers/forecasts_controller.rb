class ForecastsController < ApplicationController
  def index
  end

  def show
    forecast_form = Forecasts::ForecastAddressForm.new(forecast_params)

    if !forecast_form.valid?
      redirect_to forecasts_path, flash: { alert: "Please enter a valid address." }
      return
    end

    address = forecast_form.to_street_address
    Weather::ForecastService.forecast(address: address).tap do |response|
      @forecast_decorator = Forecasts::ForecastDecorator.new(response)
    end
  end

  private

  def forecast_params
    { address: params[:address] }
  end
end
