require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @user=users(:michael)
  end
  
  test "should not login without correct informations" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: {session: {name: "",password:""}}
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
  
  test "should login with correct information" do
    get login_path
    post login_path,params: { session: {name: @user.name, password: "password"}}
    assert_redirected_to root_path
    follow_redirect!
    assert_template "static_pages/home"
    assert_not flash.empty?
    assert_select "a[href=?]",login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", new_post_path
    delete logout_path
    assert_redirected_to login_path
    follow_redirect!
    assert_template "sessions/new"
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,count: 0
  end
end
