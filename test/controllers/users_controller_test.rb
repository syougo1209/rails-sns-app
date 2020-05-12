require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
  @user=users(:michael)
  @other_user=users(:nick)
  end
 
  test "should get new" do
    get signup_path
    assert_response :success
  end
  
  test "should redirect if edit_path when not login" do
  get edit_user_path(@user)
  assert_not flash.empty?
  assert_redirected_to login_url
  end
  
  test "should redirect if edit_path when other_user" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to root_path
  end
  
  test "should redirect if edit user when not login" do
    patch user_path(@user), params: {user: {name: "un",
    }}
    assert_not flash.empty?
    assert_redirected_to login_path
  end
  
  test "should redirect if edit user when other user" do
    log_in_as(@other_user)
    patch user_path(@user), params: {user: {name: "un",
    }}
    assert_not flash.empty?
    assert_redirected_to root_path
  end
  
  test "should redirect if delete when not login" do
    delete user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_path
  end
  
  test "should redirect if delete when other user" do
    log_in_as(@other_user)
    delete user_path(@user)
    assert_not flash.empty?
    assert_redirected_to root_path
  end
  
end
