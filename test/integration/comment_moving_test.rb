require 'test_helper'

class CommentMovingTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
   @michael=users(:michael)
   @nick=users(:nick)
   @michael_post=posts(:orange)
   @comment=comments(:comment)
   @most_recent=comments(:most_recent)
  end
  
  test "logout state should not have comment form" do
    get post_path(@michael_post)
    assert_select "input",count: 0
    log_in_as(@michael)
    get post_path(@michael_post)
    assert_select "input",count: 6
  end
  
  test "basic comment movement" do
    log_in_as(@michael)
    get post_path(@michael_post)
    assert_select "div.pagination"
    comments=assigns(:comments)
    assert_equal @most_recent,comments[0]
    assert_equal @comment,comments[1]
    post comments_path, params: {comment: {content: "hello",post_id: @michael_post.id}}
    assert_redirected_to post_path(@michael_post)
    follow_redirect!
    comments.reload
    assert_equal comments[0].content,"hello"
    delete comment_path(@comment)
    assert_redirected_to post_path(@michael_post)
    assert_not flash.empty?
  end
end
