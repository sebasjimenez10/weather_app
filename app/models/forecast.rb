class Forecast
  include ActiveModel::Model

  attr_accessor :address

  validates_presence_of :address

  validate :address_format

  def to_street_address
    StreetAddress::US.parse(address)
  end

  def address_format
    if address.present?
      parsed_address = StreetAddress::US.parse(address)

      if parsed_address.blank?
        errors.add(:address, "is not a valid address")
      end
    end
  end
end
