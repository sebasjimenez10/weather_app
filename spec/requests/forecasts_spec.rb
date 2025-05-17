require "rails_helper"

RSpec.describe "Forecasts", type: :request do
  let(:client) { Weather::API::WeatherAPI::Client.new(key: "test_key", client: client_mock) }
  let(:client_mock) { Weather::API::WeatherAPI::MockClient.new }

  before do
    allow(Weather::API::ClientBuilder).to receive(:build_client).and_return(client)
    allow(client_mock).to receive(:get).and_call_original
  end

  describe "GET /index" do
    it "returns http success" do
      get "/forecasts"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    let(:decorator) {
      double(
        city: "Irvine",
        state: "CA",
        country: "USA",
        localtime: "2025-05-16 12:00",
        cached_response: false,
        current_temp_c: 22,
        current_temp_f: 71.6,
        condition_text: "Sunny",
        condition_icon: "https://cdn.weatherapi.com/weather/64x64/day/113.png",
        forecastdays: [
          double(
            date: "2025-05-16",
            day: double(
              maxtemp_c: 25,
              mintemp_c: 15,
              mintemp_f: 59,
              maxtemp_f: 77,
              condition: double(
                text: "Sunny",
                icon: "https://cdn.weatherapi.com/weather/64x64/day/113.png"
              )
            ),
            hour: [
              double(
                time: "2025-05-16 13:00",
                temp_c: 22,
                temp_f: 44,
                condition: double(
                  text: "Sunny",
                  icon: "https://cdn.weatherapi.com/weather/64x64/day/113.png"
                )
              )
            ]
          )
        ],
        friendly_time: lambda do |time| time end,
        friendly_date: lambda do |date| date end
      )
    }

    before do
      allow(Forecasts::ForecastDecorator).to receive(:new).and_return(decorator)
    end

    it "returns http success" do
      address = "1 Civic Center Plaza, Irvine, CA 92606"
      get "/forecasts/#{URI.encode_uri_component(address)}"
      expect(response).to have_http_status(:success)
    end

    context "when the address is invalid" do
      before do
        allow(Forecasts::ForecastAddressForm).to receive(:new).and_return(double(valid?: false, errors: double(full_messages: [ "Invalid address" ])))
      end

      it "redirects to the index page with an alert" do
        get "/forecasts/invalid_address"
        expect(response).to redirect_to(forecasts_path)
        expect(flash[:alert]).to eq("Please enter a valid address.")
      end
    end
  end
end
