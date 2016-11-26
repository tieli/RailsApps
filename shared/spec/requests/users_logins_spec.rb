require 'rails_helper'

RSpec.describe "UsersLogins", type: :request do
  describe "GET /users_logins" do
    it "works! (now write some real specs)" do
      user = FactoryGirl.create(:user)
      get login_path
      expect(response).to have_http_status(200)
      visit login_path
      fill_in "Email", :with => user.email
      fill_in "Password", :with => user.password
      click_button "Log in"
      expect(current_path).to eq(root_path)
      expect(page).to have_content("Signed in successfully.")
    end
  end
end


=begin
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
=end
