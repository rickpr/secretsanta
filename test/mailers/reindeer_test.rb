require 'test_helper'

class ReindeerTest < ActionMailer::TestCase
  test "pick" do
    mail = Reindeer.pick
    assert_equal "Pick", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
