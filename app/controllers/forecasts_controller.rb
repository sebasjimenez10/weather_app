class ForecastsController < ApplicationController
  # GET /forecasts
  #
  # Retrieves the initial view in which the use can enter an address.
  #
  # @example
  #   GET /forecasts
  #
  # @return [void]
  def index
  end

  # GET /forecasts/:address
  #
  # Retrieves and displays weather forecast data for the given address.
  #
  # @example
  #   GET /forecasts/1 Civic Center Plaza, Irvine, CA 92606
  #
  # @return [void]
  def show
    forecast_form = Forecasts::ForecastAddressForm.new(forecast_params)

    if !forecast_form.valid?
      Rails.logger.error("Invalid address: #{forecast_form.errors.full_messages.join(', ')}")
      redirect_to forecasts_path, flash: { alert: "Please enter a valid address." }
      return
    end

    Weather::ForecastService.forecast(address: forecast_form.to_street_address).tap do |response|
      @forecast_decorator = Forecasts::ForecastDecorator.new(response)
    end
  end

  private

  def forecast_params
    { address: params[:address] }
  end
end
