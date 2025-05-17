require "rails_helper"

RSpec.describe Weather::API::ClientBase do
  describe "#forecast" do
    it "raises NotImplementedError" do
      expect {
        described_class.new.forecast("query")
      }.to raise_error(NotImplementedError, /Subclasses must implement the forecast method/)
    end
  end

  describe "HTTParty inclusion" do
    it "responds to HTTParty methods" do
      expect(described_class).to respond_to(:base_uri)
    end
  end
end
