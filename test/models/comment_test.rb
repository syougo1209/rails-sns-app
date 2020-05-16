require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @comment=Comment.new(content: "aaaaa",user_id: 1,post_id: 1)
  end
  test "order should be correct"do
    assert_equal comments(:most_recent), Comment.first
    assert_equal comments(:most_old), Comment.last
  end
  
  test "comment should be valid" do
    assert @comment.valid?
  end
  
  test "comment should require user_id" do
    @comment.user_id=nil
    assert_not @comment.valid?
  end
  
  test "comment should require post_id" do
    @comment.post_id=nil
    assert_not @comment.valid?
  end
  
  test "comment should not be too long" do
     @comment.content="a"*51
     assert_not @comment.valid?
  end
  
  test "comment should be present" do
    @comment.content=""
    assert_not @comment.valid?
  end
  
end
