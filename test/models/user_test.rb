require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @user=User.new(name: "Example User",prefecture:"東京都")
 end
 
 test "name should be present" do
  @user.name=""
  assert_not @user.valid?
end

end