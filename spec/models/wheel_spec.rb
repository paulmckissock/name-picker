require "rails_helper"

RSpec.describe Wheel, type: :model do
  let(:wheel) { build(:wheel) }

  it "should be valid with valid attributes" do
    expect(wheel.valid?).to be(true)
  end

  it "should not be valid without a title" do
    wheel.title = nil
    expect(wheel.valid?).to be(false)
  end

end
