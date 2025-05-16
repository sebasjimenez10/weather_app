module Forecasts
  # ForecastAddressForm is a form object that handles the address input for weather forecasts.
  # It validates the address format and provides a method to convert the address
  # into a StreetAddress::US object.
  #
  class ForecastAddressForm < FormBase
    attr_accessor :address

    validates_presence_of :address
    validate :address_format

    # Converts the address string into a StreetAddress::US object.
    #
    # @return [StreetAddress::US] The parsed address object.
    def to_street_address
      StreetAddress::US.parse(address)
    end

    # Validates the format of the address.
    # If the address is nil it adds an error as it is not valid.
    #
    # @return [void]
    def address_format
      return if address.blank?

      parsed_address = StreetAddress::US.parse(address)

      if parsed_address.blank?
        errors.add(:address, "is not a valid address")
      end
    end
  end
end
