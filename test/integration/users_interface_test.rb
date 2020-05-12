require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
   @user=users(:michael)
   @other_user=users(:nick)
  end
  
  test "invalid edit for user" do
    get login_path
    log_in_as(@user)
    get edit_user_path(@user)
    name=""
    patch user_path(@user), params: {user: {name: name,
                                            password: "password",
                                            password_confirmation: "password"}}
                                            
    assert_template "users/edit"
    assert_select "div#error_explanation"
  end
  
  test "valid edit for user" do
    get login_path
    log_in_as(@user)
    get edit_user_path(@user)
    name="user"
    picture = fixture_file_upload('test/fixtures/files/default.jpg', 'image/png')
    prefecture="神奈川県"
    patch user_path(@user), params: {user: {name: name,
                                            picture: picture,
                                            prefecture: prefecture
    }}
    assert_redirected_to user_path(@user)
    follow_redirect!
    assert_not flash.empty?
  end
  
  test "destroy action for user" do
    log_in_as(@other_user)
    delete user_path(@user)
    assert_redirected_to root_path
    follow_redirect!
    assert_not flash.empty?
    get edit_user_path(@other_user)
    assert_select "a", text: "ユーザー削除"
    delete user_path(@other_user)
    assert_redirected_to login_path
    assert_not flash.empty?
  end
  
  test "user search page moves correctly?" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
    get users_path, params: { prefecture: "東京都", search: "Nick"}
    assert_select "a[href=?]",user_path(@other_user),count: 0
    get users_path, params: { prefecture: "鳥取県", search: "Nick"}
    assert_select "a[href=?]",user_path(@other_user)
    get users_path, params: { prefecture: "東京都"}
     assert_select "a[href=?]",user_path(@other_user),count: 0
     assert_select "div.pagination"
    get users_path, params: { search: "Nick",prefecture: "都道府県を選択出来ます"}
    assert_select "a[href=?]",user_path(@other_user)
    assert_select "div.pagination",count: 0
    get users_path
     assert_select "a[href=?]",user_path(@other_user), count: 0
     assert_select "div.pagination", count: 0
   end
end
