require 'test_helper'

class RelationshipsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
 
 test "auth login for relationship" do
   assert_no_difference 'Relationship.count' do
       post relationships_path,params:{relationship: {followed_id: 1,follower_id: 2}}
   end
   assert_redirected_to login_path
   assert_not flash.empty?
   relasionship=relationships(:one)
   assert_no_difference 'Relationship.count' do
   delete relationship_path(relasionship)
   end
   assert_redirected_to login_path
   assert_not flash.empty?
 end
 
end
