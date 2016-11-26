require 'rails_helper'

RSpec.describe "UsersLogins", type: :request do
  describe "GET /users_logins" do
    it "works! (now write some real specs)" do
      user = FactoryGirl.create(:user)
      get signup_path
      expect(response).to have_http_status(200)
      visit signup_path
      fill_in "Email", :with => user.email
      fill_in "Password", :with => user.password
      fill_in "Password confirmation", :with => user.password
      click_button "Sign up"
      expect(current_path).to eq(root_path)
      expect(page).to have_content("signed up successfully")
    end
  end
end

