require "rails_helper"

RSpec.describe Weather::API::ClientBase do
  describe "singleton behavior" do
    it "returns the same instance" do
      instance1 = described_class.instance
      instance2 = described_class.instance
      expect(instance1).to be(instance2)
    end
  end

  describe "#forecast" do
    it "raises NotImplementedError" do
      expect {
        described_class.instance.forecast("query")
      }.to raise_error(NotImplementedError, /Subclasses must implement the forecast method/)
    end
  end

  describe "HTTParty inclusion" do
    it "responds to HTTParty methods" do
      expect(described_class).to respond_to(:base_uri)
    end
  end
end
