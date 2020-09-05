require 'test_helper'

class TagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @tag=Tag.new(user_id: 1,tag_name: "umi")
  end
  
  test "should be valid" do
     assert @tag.valid?
  end
  
  test "should require user_id" do
    @tag.user_id=nil
    assert_not @tag.valid?
  end
  
  test "should require name" do
     @tag.tag_name=nil
     assert_not @tag.valid?
  end
  
  test "tag name should not be too long" do
    @tag.tag_name="a"*21
    assert_not @tag.valid?
  end
end
