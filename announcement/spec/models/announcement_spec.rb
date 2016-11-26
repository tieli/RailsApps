require 'rails_helper'

RSpec.describe Announcement, type: :model do

  it "has current scope" do
    passed = Announcement.create! starts_at: 1.day.ago, ends_at: 1.hour.ago
    current = Announcement.create! starts_at: 1.hour.ago, ends_at: 1.hour.from_now
    upcoming = Announcement.create! starts_at: 1.hour.from_now, ends_at: 1.day.from_now
    expect(Announcement.current).to eq([current])
  end

  it "has current scope" do
    current = Announcement.create! starts_at: 1.hour.ago, ends_at: 1.hour.from_now
    current2 = Announcement.create! starts_at: 1.hour.ago, ends_at: 1.day.from_now
    expect(Announcement.current([current2.id])).to eq([current])
  end

  it "has current scope" do
    current = Announcement.create! starts_at: 1.hour.ago, ends_at: 1.hour.from_now
    expect(Announcement.current(nil)).to eq([current])
  end

end
