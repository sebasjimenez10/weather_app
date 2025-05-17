require "rails_helper"

RSpec.describe Weather::ForecastService do
  describe ".forecast" do
    let(:address) { instance_double(StreetAddress::US::Address, postal_code: "12345") }
    let(:api) { :weather_api }
    let(:client) { instance_double(Weather::API::WeatherAPI::Client) }
    let(:cached_response) { false }
    let(:forecast_response) { instance_double(Weather::API::WeatherAPI::Response) }
    let(:forecast_result) { Weather::ForecastService::ForecastResult.new(result: forecast_response, cached_response: cached_response) }

    before do
      allow(Weather::API::ClientBuilder).to receive(:build_client).with(name: api).and_return(client)
      allow(Rails.cache).to receive(:exist?).with(address.postal_code).and_return(cached_response)
      allow(Rails.cache).to receive(:fetch).with(address.postal_code, expires_in: 30.minutes).and_call_original
      allow(client).to receive(:forecast).with(address.postal_code).and_return(forecast_response)
    end

    it "builds the client using the provided API" do
      described_class.forecast(address: address, api: api)

      expect(Weather::API::ClientBuilder).to have_received(:build_client).with(name: api)
    end

    it "checks if the forecast data is cached" do
      described_class.forecast(address: address, api: api)

      expect(Rails.cache).to have_received(:exist?).with(address.postal_code)
    end

    it "retrieves the forecast data using the client" do
      result = described_class.forecast(address: address, api: api)

      expect(client).to have_received(:forecast).with(address.postal_code)
      expect(result.result).to eq(forecast_result.result)
      expect(result.cached_response).to eq(forecast_result.cached_response)
    end

    it "caches the forecast data for 30 minutes" do
      described_class.forecast(address: address, api: api)

      expect(Rails.cache).to have_received(:fetch).with(address.postal_code, expires_in: 30.minutes)
    end

    context "when the there is cache hit" do
      let(:cached_response) { true }

      before do
        allow(Rails.cache).to receive(:exist?).with(address.postal_code).and_return(cached_response)
        allow(Rails.cache).to receive(:fetch).with(address.postal_code, expires_in: 30.minutes).and_return(forecast_response)
      end

      it "does not call the client to fetch the forecast data" do
        described_class.forecast(address: address, api: api)

        expect(client).not_to have_received(:forecast)
      end

      it "returns the cached response" do
        result = described_class.forecast(address: address, api: api)

        expect(result.result).to eq(forecast_result.result)
        expect(result.cached_response).to eq(forecast_result.cached_response)
      end
    end
  end
end
