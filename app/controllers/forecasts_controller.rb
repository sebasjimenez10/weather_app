class ForecastsController < ApplicationController
  def index
  end

  def show
    forecast = Forecast.new(forecast_params)

    if forecast.valid?
      address = forecast.to_street_address

      Weather::ForecastService.forecast(address: address).tap do |response|
        @location = response[:location]
        @current = response[:current]
        @forecast = response[:forecast]
        @cached_response = response[:cached_response]
      end
    else
      flash.now[:alert] = "Please enter a valid address."
      render :index
    end
  end

  private

  def forecast_params
    { address: params[:address] }
  end
end
