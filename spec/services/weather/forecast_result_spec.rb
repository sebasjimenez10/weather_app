require "rails_helper"

RSpec.describe Weather::ForecastService::ForecastResult do
  let(:result_double) { instance_double(Weather::API::WeatherAPI::Response) }

  describe "#initialize" do
    it "assigns the result and cached_response attributes" do
      forecast_result = described_class.new(result: result_double, cached_response: true)
      expect(forecast_result.result).to eq(result_double)
      expect(forecast_result.cached_response).to be true
    end

    it "allows cached_response to be false" do
      forecast_result = described_class.new(result: result_double, cached_response: false)
      expect(forecast_result.cached_response).to be false
    end
  end

  describe "attr_readers" do
    subject { described_class.new(result: result_double, cached_response: true) }

    it { is_expected.to respond_to(:result) }
    it { is_expected.to respond_to(:cached_response) }
  end
end
