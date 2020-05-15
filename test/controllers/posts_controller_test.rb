require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @user=users(:michael)
    @other_user=users(:nick)
    @post=posts(:orange)
  end
  
  test "auth login" do
    get posts_path
    assert_template 'posts/index'
    get new_post_path
    assert_redirected_to login_path
    assert_not flash.empty?
    post posts_path, params: { post: { content: "hello",title:"hello" } }
    assert_redirected_to login_path
    assert_not flash.empty?
    patch post_path(@post),params: {post: {content: "aaaa",title: "aaaa"}}
    assert_redirected_to login_path
    assert_not flash.empty?
    delete post_path(@post)
    assert_redirected_to login_path
    assert_not flash.empty?
  end
  
  test "correct user" do
    log_in_as(@other_user)
    get edit_post_path(@post)
    assert_redirected_to root_path
    assert_not flash.empty?
    patch post_path(@post),params: {post: {content: "aaaa",title: "aaaa"}}
    assert_redirected_to root_path
    assert_not flash.empty?
    delete post_path(@post)
    assert_redirected_to root_path
    assert_not flash.empty?
  end
end
