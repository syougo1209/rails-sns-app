require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
  @user=users(:michael)
  @post=@user.posts.build(content: "hello",picture: "" ,title: "tokyo",latitude: 3.14,longitude: 3.1415,address:"神奈川県横浜市1-2-3")
  end
  
  test "should be valid" do
    assert @post.valid?
  end
  
  test "user id should be present" do
    @post.user_id=nil
    assert_not @post.valid?
  end
  
  test "content should be predsent" do
    @post.content=""
    assert_not @post.valid?
  end
  
  test "content should not be too long" do
    @post.content="a"*141
    assert_not @post.valid?
  end
  
  test "title should be present" do
    @post.title=""
    assert_not @post.valid?
  end
  
  test "title should not be too long" do
    @post.title="a"*51
    assert_not @post.valid?
  end

  test "should be valid if address and longitude and latitude is not present" do
    @post.address=""
    @post.longitude=nil
    @post.latitude=nil
    assert @post.valid?
  end
  
  test "associated like is destroyed" do
   @post.save
   @user.likes.create!(post_id: @post.id)
   assert_difference 'Like.count', -1 do
     @post.destroy
   end
  end
  
  test "associated comment is destroyed in post" do
    @post.save
    @user.comments.create!(content: "ruby",post_id: @post.id)
    assert_difference 'Comment.count', -1 do
     @post.destroy
   end
  end
end
