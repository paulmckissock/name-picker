require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  it "should be valid" do
    expect(user.valid?).to be(true)
  end

  it "name should be present" do
    user.username = ""
    expect(user.valid?).to be(false)
  end

  it "name should be unique" do
    duplicate_user = user.dup
    user.save
    expect(duplicate_user.valid?).to be(false)
  end

  it "email should be present" do
    user.email = nil
    expect(user).not_to be_valid
  end

  it "password should be present (nonblank)" do
    user.password = user.password_confirmation = ""
    expect(user.valid?).to be(false)
  end
end
