require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest


  def setup
    @user = users(:michael)
  end

  test "login with valid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, { email: @user.email, password: 'password' }
    #assert is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    #assert_template 'articles/show'
    assert_template 'welcome/home'
    #assert_select "a[href=?]", login_path, count: 0
    #assert_select "a[href=?]", logout_path
    #assert_select "a[href=?]", user_path(@user)
  end

  #1. Visit the login path.
  #2. Verify that the new sessions form renders properly.
  #3. Post to the sessions path with an invalid params hash.
  #4. Verify that the new sessions form gets re-rendered and that a flash message appears.
  #5. Visit another page (such as the Home page).
  #6 Verify that the flash message doesn’t appear on the new page. 

=begin
  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: "", password: "" }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
=end

end
