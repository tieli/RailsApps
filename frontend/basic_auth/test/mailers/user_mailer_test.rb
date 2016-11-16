require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "password_reset:string" do
    mail = UserMailer.password_reset:string
    # Fix me XXX
    #assert_equal "Password reset:string", mail.subject
    #assert_equal ["to@example.org"], mail.to
    #assert_equal ["from@example.com"], mail.from
    #assert_match "Hi", mail.body.encoded
  end

end
