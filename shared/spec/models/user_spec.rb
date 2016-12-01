require 'rails_helper'

RSpec.describe User do

  describe "User authenticate" do
    it "authenticates with matching username and password" do
      user = FactoryGirl.create(:user, email: "batman@foo.com", password: "secrete", password_confirmation: "secrete")
      expect(User.authenticate("batman@foo.com", "secrete")).to eq(user)
    end

    it "does not authenticate with incorrect password" do
      user = User.create(email: "batman@foo.com", password: "secret", password_confirmation: "secret")
      expect(User.authenticate("batman@foo.com", "wrongsecret")).to  be_nil
    end
  end

  describe "#send_password_reset" do
    let(:user) { FactoryGirl.create(:user) }

    it "generates a unique password_reset_token each time" do
      user.send_password_reset
      last_token = user.password_reset_token
      user.send_password_reset
      expect(user.password_reset_token).not_to eq(last_token)
    end

    it "saves the time the password reset was sent" do
      user.send_password_reset
      expect(user.reload.password_reset_sent_at).to be_present
    end

    it "delivers email to user" do
      user.send_password_reset
      expect(ActionMailer::Base.deliveries.last.to).to include(user.email)
    end
  end

end
