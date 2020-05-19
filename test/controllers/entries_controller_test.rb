require 'test_helper'

class EntriesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user=users(:nick)
  end
  
  test "authlogin for entry" do
    post entries_path, params: { user_id: @user.id }
    assert_redirected_to login_path
    assert_not flash.empty?
  end
end
