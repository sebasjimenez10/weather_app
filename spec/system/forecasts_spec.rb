require 'rails_helper'

RSpec.describe "Forecasts", type: :system do
  let(:client) { Weather::API::WeatherAPI::Client.new(key: "test_key", client: client_mock) }
  let(:client_mock) { Weather::API::WeatherAPI::MockClient.new }

  before do
    allow(Weather::API::ClientBuilder).to receive(:build_client).and_return(client)
    allow(client_mock).to receive(:get).and_call_original
  end

  it "submits a valid ZIP code and displays forecast" do
    visit forecasts_path
    fill_in "forecast-address", with: "1 Civic Center, Irvine, CA 92606"
    click_button "Get Forecast"

    expect(page).to have_content("Forecast Details").or have_content("Current status")
    expect(page).to have_content("Irvine")
    expect(page).to have_content("California")
    expect(page).to have_content("USA")
  end

  it "shows an error message for invalid ZIP code" do
    visit forecasts_path
    fill_in "forecast-address", with: "A"
    click_button "Get Forecast"

    expect(page).to have_content("Please enter a valid address.")
  end
end
