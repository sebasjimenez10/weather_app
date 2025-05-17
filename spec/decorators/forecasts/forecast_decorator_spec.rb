require "rails_helper"

RSpec.describe Forecasts::ForecastDecorator do
  let(:location) do
    double(
      name: "San Francisco",
      region: "California",
      country: "USA",
      localtime: "2024-06-01 12:00"
    )
  end

  let(:condition) do
    double(
      text: "Sunny",
      icon: "//cdn.weatherapi.com/weather/64x64/day/113.png"
    )
  end

  let(:current) do
    double(
      temp_c: 20.5,
      temp_f: 68.9,
      condition: condition
    )
  end

  let(:forecastday) { [ double(date: "2024-06-01"), double(date: "2024-06-02") ] }
  let(:forecast) { double(forecastday: forecastday) }

  let(:result) do
    double(
      location: location,
      current: current,
      forecast: forecast
    )
  end

  let(:cached_response) { { "cached" => true } }

  let(:forecast_result) do
    double(
      result: result,
      cached_response: cached_response
    )
  end

  subject(:decorator) { described_class.new(forecast_result) }

  describe "#city" do
    it "returns the city name" do
      expect(decorator.city).to eq("San Francisco")
    end
  end

  describe "#state" do
    it "returns the region/state" do
      expect(decorator.state).to eq("California")
    end
  end

  describe "#country" do
    it "returns the country" do
      expect(decorator.country).to eq("USA")
    end
  end

  describe "#localtime" do
    it "returns the localtime" do
      expect(decorator.localtime).to eq("2024-06-01 12:00")
    end
  end

  describe "#cached_response" do
    it "returns the cached response" do
      expect(decorator.cached_response).to eq({ "cached" => true })
    end
  end

  describe "#current_temp_c" do
    it "returns the current temperature in Celsius" do
      expect(decorator.current_temp_c).to eq(20.5)
    end
  end

  describe "#current_temp_f" do
    it "returns the current temperature in Fahrenheit" do
      expect(decorator.current_temp_f).to eq(68.9)
    end
  end

  describe "#condition_text" do
    it "returns the current weather condition text" do
      expect(decorator.condition_text).to eq("Sunny")
    end
  end

  describe "#condition_icon" do
    it "returns the current weather condition icon" do
      expect(decorator.condition_icon).to eq("//cdn.weatherapi.com/weather/64x64/day/113.png")
    end
  end

  describe "#forecastdays" do
    it "returns the forecast days" do
      expect(decorator.forecastdays).to eq(forecastday)
    end
  end
end
