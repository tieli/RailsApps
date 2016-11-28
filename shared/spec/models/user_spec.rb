require 'rails_helper'

RSpec.describe User do

  it "authenticates with matching username and password" do
    user = FactoryGirl.create(:user, email: "batman@foo.com", password: "secrete")
    expect(User.authenticate("batman@foo.com", "secrete")).to eq(user)
  end

  it "does not authenticate with incorrect password" do
    user = User.create(email: "batman@foo.com", password: "secret")
    expect(User.authenticate("batman@foo.com", "wrongsecret")).to  be_nil
  end

end
