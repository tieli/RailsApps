require 'rails_helper'
require 'faker'

RSpec.describe "Articles", type: :request do
  describe "GET /articles" do

    it "it creates article", js: true do
      user = FactoryGirl.create(:user)
      visit root_path
      click_link "New Article"
      expect(page).to have_content("Not authorized")
      fill_in "Email", :with => user.email
      fill_in "Password", :with => user.password
      click_button "Log in"
      click_link "New Article"
      fill_in "Title", :with => "The lord of rings"
      fill_in "Content", :with => Faker::Lorem.paragraph
      click_button "Create Article"
      expect(page).to have_content("successfully created.")
    end

  end
end
