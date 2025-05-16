class Forecast
  include ActiveModel::Model

  attr_accessor :address

  validates_presence_of :address

  def to_street_address
    StreetAddress::US.parse(address)
  end
end
