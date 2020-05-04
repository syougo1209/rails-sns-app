class AddIndexToPostsTitle < ActiveRecord::Migration[5.1]
  def change
    add_index :posts, :title
  end
end
