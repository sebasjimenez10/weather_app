require "rails_helper"

RSpec.describe "Forecasts", type: :request do
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
              condition: double(
                text: "Sunny",
                icon: "https://cdn.weatherapi.com/weather/64x64/day/113.png"
              )
            ),
            hour: [
              double(
                time: "2025-05-16 13:00",
                temp_c: 22,
                condition: double(
                  text: "Sunny",
                  icon: "https://cdn.weatherapi.com/weather/64x64/day/113.png"
                )
              )
            ]
          )
        ]
      )
    }

    before do
      allow(Forecasts::ForecastDecorator).to receive(:new).and_return(decorator)
    end

    it "returns http success" do
      address = "1 Civic Center Plaza, Irvine, CA 92606"
      get "/forecasts/#{CGI.escape(address)}"
      expect(response).to have_http_status(:success)
    end
  end
end
