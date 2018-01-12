require 'test_helper'

class AuthMailerTest < ActionMailer::TestCase
  test "new_auth" do
    mail = AuthMailer.new_auth
    assert_equal "New auth", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
