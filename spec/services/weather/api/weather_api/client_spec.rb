require "rails_helper"

RSpec.describe Weather::API::WeatherAPI::Client do
  describe "#initialize" do
    before do
      allow(Rails.application.credentials[Rails.env]).to receive(:weather_api_key).and_return("test_key")
    end

    it "initializes with the API key from Rails credentials" do
      client = described_class.new
      expect(client.auth).to eq({ key: "test_key" })
    end
  end

  describe "#forecast" do
    let(:client) { described_class.new("test_key") }
    let(:client_class) { described_class }
    let(:zip_code) { "12345" }
    let(:response) { instance_double(Weather::API::WeatherAPI::Response) }

    before do
      allow(client_class).to receive(:get).and_return(response)
      allow(Weather::API::WeatherAPI::Response).to receive(:new).with(response).and_return(response)
    end

    it "fetches the weather forecast for the given zip code" do
      client.forecast(zip_code)

      expect(client_class).to(
        have_received(:get)
          .with(
            "/v1/forecast.json",
            query: {
              q: zip_code,
              key: "test_key"
            },
            format: :plain
          )
      )
    end
  end
end
