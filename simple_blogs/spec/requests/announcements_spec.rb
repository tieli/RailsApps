require 'rails_helper'

RSpec.describe "Announcements", type: :request do
  describe "GET /announcements" do
    it "works! (now write some real specs)" do
      Announcement.create! message: "Hello World", starts_at: 1.hours.ago, ends_at: 1.hour.from_now
      Announcement.create! message: "Upcoming", starts_at: 10.minutes.from_now, ends_at: 1.hour.from_now
      visit root_path
      expect(page).to have_content("Hello World")
      expect(page).not_to have_content("Upcoming")
      click_on "hide announcement"
      expect(page).not_to have_content("Hello World")
    end

    it "works! (now write some real specs)" do
      Announcement.create! message: "Hello World", starts_at: 1.hours.ago, ends_at: 1.hour.from_now
      visit root_path
      expect(page).to have_content("Hello World")
      click_on "hide announcement"
      expect(page).not_to have_content("Hello World")
    end
  end
end
