require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @user=users(:michael)
    @other_user=users(:nick)
    @comment=comments(:comment)
  end
  test "authlogin for comment" do
    post comments_path, params: {comment: {content: "hello"}}
    assert_redirected_to login_path
    assert_not flash.empty?
    delete comment_path(@comment)
    assert_redirected_to login_path
    assert_not flash.empty?
  end
  
  test "correct user for comment" do
    log_in_as(@other_user)
    get post_path(@comment.post_id)
    delete comment_path(@comment)
    assert_redirected_to post_path(@comment.post_id)
    assert_not flash.empty?
  end
end
