require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do
  describe "GET /password_resets" do
    it "emails user when requesting password reset" do
      user = FactoryGirl.create(:user)
      visit login_path
      click_link "Password"
      fill_in "Email", :with => user.email
      click_button "Reset Password"
      expect(current_path).to eq(root_path)
      expect(page).to have_content("Email sent")
    end
  end
end
