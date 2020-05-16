require 'test_helper'

class RoomTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user=users(:nick)
    @room=rooms(:one)
  end
  
  test "associated message should be destroyed when room is destroyed" do
    @user.messages.create!(content: "hello",room_id: 1)
    assert_difference 'Message.count', -1 do
        @room.destroy
    end
  end
  
   test "associated entries should be destroyed when room is destroyed" do
    @user.entries.create!(room_id: 1)
    assert_difference 'Entry.count', -1 do
        @room.destroy
    end
  end
end
