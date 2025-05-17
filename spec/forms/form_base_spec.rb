require "rails_helper"

RSpec.describe FormBase, type: :model do
  it "includes ActiveModel::Model" do
    expect(FormBase.included_modules).to include(ActiveModel::Model)
  end
end
