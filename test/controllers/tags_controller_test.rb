require 'test_helper'

class TagsControllerTest < ActionDispatch::IntegrationTest
   def setup
    @user=users(:jon)
    @other_user=users(:nick)
    @tag=tags(:tag)
   end
  
  test "auth login test for tags" do
    get tag_path(@tag)
    assert_redirected_to login_path
    assert_not flash.empty?
    post tags_path, params: { tag: { tag_name: "海" } }
    assert_redirected_to login_path
    assert_not flash.empty?
    delete tag_path(@tag)
    assert_redirected_to login_path
    assert_not flash.empty?
  end
  
  test "correct user test for tags" do
    log_in_as(@other_user)
    delete tag_path(@tag)
    assert_redirected_to root_path
    assert_not flash.empty?
  end
end
