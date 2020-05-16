require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "authlogin for like" do
    user=users(:michael)
    post likes_path,params: {like: {post_id: 1,user_id: 1}}
    assert_redirected_to login_path 
    delete like_path(1)
  end
end
