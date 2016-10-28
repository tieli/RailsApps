require 'rails_helper'

RSpec.describe User, type: :model do

  it "authenticates with matching username and password" do
    user = User.create!(email: "tiejli@yahoo.com", password: "password")
    expect(User.authenticate("tiejli@yahoo.com", "password")).to eq(user)
  end

  it "authenticates with matching username and password" do
    user = User.create!(email: "tiejli@hotmail.com", password: "secret")
    expect(User.authenticate("tiejli@hotmail.com", "incorrect")).to be_nil
  end

  it "authenticates with using factory girl" do
    user = FactoryGirl.create(:user)
    expect(User.authenticate(user.email, user.password)).to eq(user)
  end

end
