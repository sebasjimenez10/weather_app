module Forecasts
  class ForecastAddressForm < FormBase
    attr_accessor :address

    validates_presence_of :address
    validate :address_format

    def to_street_address
      StreetAddress::US.parse(address)
    end

    def address_format
      return if address.blank?

      parsed_address = StreetAddress::US.parse(address)

      if parsed_address.blank?
        errors.add(:address, "is not a valid address")
      end
    end
  end
end
