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
    let(:client) { described_class.new(key: "test_key", client: client_mock) }
    let(:client_class) { Weather::API::WeatherAPI::MockClient }
    let(:client_mock) { client_class.new }
    let(:zip_code) { "12345" }

    before do
      allow(client_class).to receive(:new).and_return(client_mock)
      allow(client_mock).to receive(:get).and_call_original
    end

    it "fetches the weather forecast for the given zip code" do
      client.forecast(zip_code)

      expect(client_mock).to(
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
