require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
   @relationship=Relationship.new(followed_id: 1,follower_id: 2)
  end
  
  test "relationship should be valid" do
     assert @relationship.valid?
  end
  
  test "relationship require followers_id" do
    @relationship.follower_id=nil
    assert_not @relationship.valid?
  end
  
  test "relationship require following_id" do
    @relationship.followed_id=nil
    assert_not @relationship.valid?
  end
end
