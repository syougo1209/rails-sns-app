require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
   def setup
    @message=Message.new(user_id: 1, room_id: 1,content: "message")
   end
   
  test "should be valid for entry" do
    assert @message.valid?
  end
  
  test "entry should require user_id" do
    @message.user_id=nil
    assert_not @message.valid?
  end
  
  test "entry should require room_id" do
    @message.room_id=nil
    assert_not @message.valid?
  end
  
  test "entry content should be present" do
    @message.content=""
    assert_not @message.valid?
  end
  
  test "entry content should not be too long" do
    @message.content="a"*101
    assert_not @message.valid?
  end
end
