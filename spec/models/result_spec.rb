require "rails_helper"

RSpec.describe Result, type: :model do
  let(:user) { create(:user) }
  let(:wheel) { create(:wheel) }
  let(:participant) { create(:participant, wheel: wheel) }
  let(:result) { build(:result, wheel: wheel, participant_name: participant.name, user: user) }

  it "should be valid with valid attributes" do
    expect(result.valid?).to be(true)
  end

  it "should not be valid without a wheel" do
    result.wheel = nil
    expect(result.valid?).to be(false)
  end

  it "should not be valid without a participant name" do
    result.participant_name = nil
    expect(result.valid?).to be(false)
  end
end
