require 'test_helper'

class FollowingRelationshipTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
  @user=users(:jon)
  @other_user=users(:nick)
  log_in_as(@user)
  end
  
  test "following page test" do
    get following_user_path(@user)
    following=assigns(:following)
    assert_not following.include?(@other_user)
    assert_select "a[href=?]", user_path(@other_user),count: 0
    @user.follow(@other_user)
    get following_user_path(@user)
    following.reload
    assert following.include?(@other_user)
    assert_select "a[href=?]", user_path(@other_user)
  end
  
  test "followers page test" do
    log_in_as(@other_user)
    @other_user.unfollow(@user)
    get followers_user_path(@user)
    followers=assigns(:followers)
    assert_not followers.include?(@other_user)
    @other_user.follow(@user)
    get followers_user_path(@user)
    followers.reload
    assert followers.include?(@other_user)
    assert_select "a[href=?]", user_path(@other_user),count: 2 #操作視点がother_userなので
  end
  
  test "follow success test for http method" do
    get user_path(@other_user)
    assert_match "フォロー", response.body
    assert_difference '@user.following.count', 1 do
      post relationships_path, params: { followed_id: @other_user.id }
    end
    follow_redirect!
    assert_match "フォロー解除", response.body
  end
  
   test "follow success test for ajax" do
    get user_path(@other_user)
    assert_match "フォロー", response.body
    assert_difference '@user.following.count', 1 do
      post relationships_path, xhr: true, params: { followed_id: @other_user.id }
    end
    assert_match "フォロー解除", response.body
  end
  
  test "unfollow success test for http method" do
    @user.follow(@other_user)
    get user_path(@other_user)
    assert_match "フォロー解除", response.body
    relationship=Relationship.find_by(followed_id: @other_user.id,follower_id: @user.id)
    assert_difference '@user.following.count', -1 do
     delete relationship_path(relationship)
    end
    follow_redirect!
    assert_match "フォロー", response.body
  end
  
  test "unfollow success test for ajax method" do
    @user.follow(@other_user)
    get user_path(@other_user)
    assert_match "フォロー解除", response.body
    relationship=Relationship.find_by(followed_id: @other_user.id,follower_id: @user.id)
    assert_difference '@user.following.count', -1 do
     delete relationship_path(relationship),xhr: true
    end
    assert_match "フォロー", response.body
  end

end
