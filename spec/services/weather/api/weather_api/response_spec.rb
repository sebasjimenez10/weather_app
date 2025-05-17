require "rails_helper"

RSpec.describe Weather::API::WeatherAPI::Response do
  let(:json_response) do
    {
      location: {
        name: "Irvine",
        region: "California",
        country: "USA"
      },
      current: {
        temp_c: 14.0,
        condition: {
          text: "Partly cloudy"
        }
      },
      forecast: {
        forecastday: [
          {
            date: "2024-06-01",
            day: {
              maxtemp_c: 18.0,
              mintemp_c: 10.0
            }
          }
        ]
      }
    }.to_json
  end

  subject(:response) { described_class.new(json_response) }

  describe "#initialize" do
    it "parses the JSON and stores it as OpenStruct" do
      expect(response.data).to be_a(OpenStruct)
      expect(response.data.location.name).to eq("Irvine")
    end

    it "raises JSON::ParserError for invalid JSON" do
      expect { described_class.new("invalid json") }.to raise_error(JSON::ParserError)
    end
  end

  describe "#location" do
    it "returns the location data as OpenStruct" do
      expect(response.location).to be_a(OpenStruct)
      expect(response.location.country).to eq("USA")
    end
  end

  describe "#current" do
    it "returns the current weather data as OpenStruct" do
      expect(response.current).to be_a(OpenStruct)
      expect(response.current.temp_c).to eq(14.0)
      expect(response.current.condition.text).to eq("Partly cloudy")
    end
  end

  describe "#forecast" do
    it "returns the forecast data as OpenStruct" do
      expect(response.forecast).to be_a(OpenStruct)
      expect(response.forecast.forecastday.first.day.maxtemp_c).to eq(18.0)
    end
  end

  context "when some keys are missing" do
    let(:partial_json) { { location: { name: "Irvine" } }.to_json }
    subject(:partial_response) { described_class.new(partial_json) }

    it "returns nil for missing keys" do
      expect(partial_response.current).to be_nil
      expect(partial_response.forecast).to be_nil
      expect(partial_response.location.name).to eq("Irvine")
    end
  end
end
