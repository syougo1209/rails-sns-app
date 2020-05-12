require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "order should be correct"do
    assert_equal comments(:most_recent), Comment.first
    assert_equal comments(:most_old), Comment.last
  end
end
