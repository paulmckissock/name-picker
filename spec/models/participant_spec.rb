require "rails_helper"

RSpec.describe Participant, type: :model do
  let(:wheel) { create(:wheel) }
  let(:participant) { create(:participant, wheel: wheel) }

  it "should be valid" do
    expect(participant.valid?).to be(true)
  end

  it "name should be present" do
    participant.name = ""
    expect(participant.valid?).to be(false)
  end
end
