require 'test_helper'

class LikesInterfaceTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user=users(:nick)
    @liked_post=posts(:most_recent)
    @user.favorite(@liked_post)
    @like_post=posts(:yokohama)
  end
  
  test "like interface test" do
     log_in_as(@user)
     get user_path(@user)
     likeposts=assigns(:likeposts)
     assert likeposts.include?(@liked_post)
     assert_not likeposts.include?(@like_post)
     get post_path(@like_post)
     assert_match "0いいね", response.body
     assert_select 'i.far'
     assert_select 'i.fas', count: 0
     post likes_path,xhr: true, params: { post_id: 2 }
     assert_match "1いいね", response.body
     assert_select 'i.far', count: 0
     assert_select 'i'
     get user_path(@user)
     likeposts.reload
     assert likeposts.include?(@liked_post)
     assert likeposts.include?(@like_post)
     assert_equal likeposts[0], @like_post
  end
end
