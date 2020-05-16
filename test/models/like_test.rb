require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @like=Like.new(post_id: 1,user_id: 1)
  end
  
  test "should be valid for like" do
    assert @like.valid?
  end
  
  test "like should require post_id" do
    @like.post_id=nil
    assert_not @like.valid?
  end
  
   test "like should require user_id" do
    @like.user_id=nil
    assert_not @like.valid?
  end
  
end
