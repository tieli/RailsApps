require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase

  def setup
    @base_title = "Rails Apps --"
  end

  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "#{@base_title} Home"
  end

end
