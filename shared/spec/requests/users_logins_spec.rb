require 'rails_helper'

RSpec.describe "UsersLogins", type: :request do
  describe "GET /users_logins" do

    it "works! (now write some real specs)", js: true do
      user = FactoryGirl.create(:user)
      get login_path
      expect(response).to have_http_status(200)
      visit login_path
      fill_in "Email", :with => user.email
      fill_in "Password", :with => user.password
      click_button "Log in"
      sleep 5
      expect(current_path).to eq(root_path)
      expect(page).to have_content("Signed in successfully.")
    end

  end
end

