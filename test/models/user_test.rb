require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @user=User.new(name: "Example User",prefecture:"東京都",
                   password: "password",password_confirmation:"password")
    @post=posts(:orange)
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

test "associated post should be destroyed" do
    @user.save
    @user.posts.create!(content:"aaaa",title: "aaaaa")
    assert_difference 'Post.count', -1 do
        @user.destroy
    end
end

test "associated like relation should be destroyed" do
    @user.save
    @user.likes.create!(post_id: 1)
    assert_difference 'Like.count', -1 do
        @user.destroy
    end
 end
 
 test "associated user relationships should be destroyed" do
 @user.save
 @user.active_relationships.create!(followed_id: 1)
 assert_difference 'Relationship.count', -1 do
        @user.destroy
    end
end

test "associated messages should be destroyed" do
    @user.save
    @user.comments.create!(content: "hello",post_id: 1)
    assert_difference 'Comment.count', -1 do
        @user.destroy
    end
end

test "associated message should be destroyed" do
    @user.save
    @user.messages.create!(content: "hello",room_id: 1)
    assert_difference 'Message.count', -1 do
        @user.destroy
    end
end
end