require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user=users(:michael)
  end
  
  test "invalid signup" do
    get signup_path
    assert_no_difference "User.count" do
      post users_path params: {user: {name:"",
                                    password:"",
                                    password_confirmation:"",
                                    prefecture:"東京都"}}
      end
    assert_template "users/new"
    assert_select "div#error_explanation"
  end
  
  test "valid signup" do
    get signup_path
    assert_difference "User.count", 1 do
      post users_path params: {user: {name:"rails",
                                    password:"password",
                                    password_confirmation:"password",
                                    prefecture:""}}
      end
    follow_redirect!
    assert_template 'static_pages/home'
    assert_not flash.empty?
  end
  
  test "signup with not unique name" do
    get signup_path
    assert_no_difference "User.count" do
      post users_path params: {user: { name: @user.name,
                                       password:"password",
                                       password_confirmation:"password",
                                       prefecture:"東京都"}}
      end
    assert_template 'users/new'
    assert_select "div#error_explanation"
  end
end
