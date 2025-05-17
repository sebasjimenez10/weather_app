module Forecasts
  # ForecastAddressForm is a form object that handles the address input for weather forecasts.
  # It validates the address presence and provides a method to convert the address
  # into a StreetAddress::US object.
  #
  class ForecastAddressForm < FormBase
    attr_accessor :address

    validates_presence_of :address

    # Converts the address string into a StreetAddress::US object.
    #
    # @return [StreetAddress::US] The parsed address object.
    def to_street_address
      # Allows for a 5-digit postal code to be passed in as a string.
      # StreetAddress::US.parse will return nil if the string is not a valid address,
      # but a zip code is enough for to get a forecast.
      address_class = StreetAddress::US::Address
      parser_class = StreetAddress::US

      return address_class.new(postal_code: address, number: "") if address.match?(/^\d{5}$/)

      parsed_address = parser_class.parse(address)
      parsed_address = address_class.new(number: address) if parsed_address.blank?

      parsed_address
    end
  end
end
