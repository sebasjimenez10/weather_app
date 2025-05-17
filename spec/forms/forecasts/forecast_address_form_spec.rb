require "rails_helper"

RSpec.describe Forecasts::ForecastAddressForm, type: :model do
  subject { described_class.new(address: address) }

  let(:valid_address) { "1600 Pennsylvania Ave, Washington, DC 20500" }
  let(:invalid_address) { "Not a real address" }
  let(:blank_address) { "" }

  describe "validations" do
    context "when address is present and valid" do
      let(:address) { valid_address }

      it "is valid" do
        expect(subject).to be_valid
      end
    end

    context "when address is blank" do
      let(:address) { blank_address }

      it "is not valid" do
        expect(subject).not_to be_valid
        expect(subject.errors[:address]).to include("can't be blank")
      end
    end

    context "when address is nil" do
      let(:address) { nil }

      it "is not valid" do
        expect(subject).not_to be_valid
        expect(subject.errors[:address]).to include("can't be blank")
      end
    end

    context "when address is present but invalid" do
      let(:address) { invalid_address }

      it "is not valid" do
        expect(subject).not_to be_valid
        expect(subject.errors[:address]).to include("is not a valid address")
      end
    end
  end

  describe "#to_street_address" do
    context "when address is valid" do
      let(:address) { valid_address }

      it "returns a StreetAddress::US::Address object" do
        result = subject.to_street_address
        expect(result).to be_a(StreetAddress::US::Address)
        expect(result.to_s).to include("1600 Pennsylvania Ave")
      end
    end

    context "when address is invalid" do
      let(:address) { invalid_address }

      it "returns nil" do
        expect(subject.to_street_address).to be_nil
      end
    end

    context "when address is blank" do
      let(:address) { blank_address }

      it "returns nil" do
        expect(subject.to_street_address).to be_nil
      end
    end
  end
end
