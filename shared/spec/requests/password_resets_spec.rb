require 'rails_helper'

describe "PasswordResets" do

  it "emails user when requesting password reset" do
    user = FactoryGirl.create(:user)
    visit login_path
    click_link "Forgot your password"
    fill_in "Email", :with => user.email
    click_button "Reset Password"
    expect(current_path).to eq(root_path)
    expect(page).to have_content("Email sent")
    expect(ActionMailer::Base.deliveries.last.to).to include(user.email)
  end

  it "does not email invalid user when requesting password reset" do
    visit login_path
    click_link "Forgot your password"
    fill_in "Email", :with => "nobody@example.com"
    click_button "Reset Password"
    expect(current_path).to eq(root_path)
    expect(page).to have_content("Email sent")
    expect(ActionMailer::Base.deliveries.last).to be_nil
  end

  it "updates the user password when confirmation matches", js: true do
    user = FactoryGirl.create(:user, :password_reset_token => "something", :password_reset_sent_at => 1.hour.ago)
    visit edit_password_reset_path(user.password_reset_token)
    fill_in "Password", :with => "foobar"
    click_button "Update Password"
    #expect(page).to have_content("Password doesn't match confirmation")
    expect(page).to have_content("doesn't match")
    fill_in "Password", :with => "foobar"
    fill_in "Password confirmation", :with => "foobar"
    click_button "Update Password"
    expect(page).to have_content("Password has been reset")
  end

  it "reports when password token has expired" do
    user = FactoryGirl.create(:user, :password_reset_token => "something", :password_reset_sent_at => 5.hour.ago)
    visit edit_password_reset_path(user.password_reset_token)
    fill_in "Password", :with => "foobar"
    fill_in "Password confirmation", :with => "foobar"
    click_button "Update Password"
    expect(page).to have_content("Password reset has expired")
  end

=begin
  it "raises record not found when password token is invalid" do
    expect {
      visit edit_password_reset_path("invalid")
    }.to raise_exception(ActiveRecord::RecordNotFound)
  end
=end

end
