require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @user=User.new(name: "Example User",prefecture:"東京都",
                   password: "password",password_confirmation:"password")
  end
 
 test "should be valid" do
   @user.valid?
 end
 
 test "name should be present" do
  @user.name=""
  assert_not @user.valid?
 end
 
 test "name should not be too long" do
 @user.name = "a" * 21
 assert_not @user.valid?
 end
 
 test "name shoul be unique" do
   other_user=@user.dup
   @user.save
   assert_not other_user.valid?
 end

test "password should be relatively long" do
  @user.password = @user.password_confirmation="a"
  assert_not @user.valid?
end

end