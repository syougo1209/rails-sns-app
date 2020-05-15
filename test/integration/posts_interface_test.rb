require 'test_helper'

class PostsInterfaceTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
   def setup
     @user=users(:michael)
     @other_user=users(:nick)
     @post=posts(:yokohama)
     @other_post=posts(:shinjuku)
   end
   
   test "series test of new,edit,update,create,destroy post action" do
     log_in_as(@user)
     get new_post_path
     assert_template "posts/new"
     post posts_path, params: {post: {content: "",title:""}}
     assert_select 'div#error_explanation'
     assert_difference 'Post.count', 1 do
      post posts_path, params: { post: { content: "hello",title:"hello" } }
    end
    assert_redirected_to post_path(Post.last)
    follow_redirect!
    assert_select "div#map1", count: 0
    assert_select 'img',count: 1 #userimage(default)
    assert_match Post.last.content, response.body
    assert_select 'a[href=?]', edit_post_path(Post.last)
    assert_select 'a', text: "投稿の削除"
    get edit_post_path(Post.last)
    patch post_path(Post.last),params: {post: {content: "",title:""}}
    assert_select 'div#error_explanation'
    picture = fixture_file_upload('test/fixtures/files/default.jpg', 'image/png')
    patch post_path(Post.last), params: { post: { content: "hello",title:"hello",
                                                  latitude: 154,longitude: 130,
                                                  picture: picture,address: "横須賀市"
                                                       } }
    assert_redirected_to post_path(Post.last)
    follow_redirect!
    assert_select 'div#map1'
    assert_select 'img',count: 2
    delete post_path(Post.last)
    assert_redirected_to root_path
    follow_redirect!
    assert_not flash.empty?
   end
   
   test "keyword and place search for post" do
    get posts_path
    get posts_path, params: {prefecture: "横浜"}
    assert_select 'div.pagination'
    assert_select "a[href=?]",post_path(@post)
    assert_select "a[href=?]",post_path(@other_post),count: 0
    get posts_path, params: {search: "中華街"}
    assert_select 'div.pagination',count: 0
    assert_select "a[href=?]",post_path(@post)
    assert_select "a[href=?]",post_path(@other_post),count: 0
    get posts_path, params: {search: "中華街", prefecture: "神奈川"}
    assert_select 'div.pagination',count: 0
    assert_select "a[href=?]",post_path(@post)
    assert_select "a[href=?]",post_path(@other_post),count: 0
    get posts_path, params: {search: "", prefecture: ""}
    assert 'div.pagination',count: 0
    assert_select "a[href=?]",post_path(@post),count: 0
   end
   
   test "ranking page test" do
       log_in_as(@user)
       log_in_as(@other_user)
       @user.likes.create!(post_id: @post.id)
       @user.likes.create!(post_id: @other_post.id)
       @other_user.likes.create!(post_id: @post.id)
       get ranking_posts_path
       posts=assigns(:posts)
       assert_equal @post, posts[0]
       assert_equal @other_post, posts[1]
       assert_select "a[href=?]",post_path(@post),count: 1
       assert_select "a[href=?]",post_path(@other_post),count: 1
       get ranking_posts_path, params: {prefecture: "神奈川県", search: "すべての月"}
       assert_select "a[href=?]",post_path(@post),count: 1
       assert_select "a[href=?]",post_path(@other_post),count: 0
       get ranking_posts_path, params: {prefecture: "神奈川県", search: "6月"}
       assert_select "a[href=?]",post_path(@post),count: 0
       assert_select "a[href=?]",post_path(@other_post),count: 0
       get ranking_posts_path, params: {prefecture: "都道府県を選択出来ます", search: "8月"}
       assert_select "a[href=?]",post_path(@post),count: 0
       assert_select "a[href=?]",post_path(@other_post),count: 1
   end
end
