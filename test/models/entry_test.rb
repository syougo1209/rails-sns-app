require 'test_helper'

class EntryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @entry=Entry.new(user_id: 1, room_id: 1)
  end
  
  test "should be valid for entry" do
    assert @entry.valid?
  end
  
  test "entry should require user_id" do
    @entry.user_id=nil
    assert_not @entry.valid?
  end
  
  test "entry should require room_id" do
    @entry.room_id=nil
    assert_not @entry.valid?
  end
  
end
