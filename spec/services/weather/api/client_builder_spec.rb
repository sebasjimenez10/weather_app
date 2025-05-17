require "rails_helper"

RSpec.describe Weather::API::ClientBuilder do
  describe ".build_client" do
    context "when name is :weather_api" do
      it "returns an instance of Weather::API::WeatherAPI::Client" do
        client = described_class.build_client(name: :weather_api)
        expect(client).to be_a(Weather::API::WeatherAPI::Client)
      end
    end

    context "when name is unsupported" do
      it "raises a RuntimeError" do
        expect {
          described_class.build_client(name: :unknown_api)
        }.to raise_error(RuntimeError, "Unsupported client")
      end

      it "raises a RuntimeError for nil name" do
        expect {
          described_class.build_client(name: nil)
        }.to raise_error(RuntimeError, "Unsupported client")
      end

      it "raises a RuntimeError for string name" do
        expect {
          described_class.build_client(name: "weather_api")
        }.to raise_error(RuntimeError, "Unsupported client")
      end
    end
  end
end
