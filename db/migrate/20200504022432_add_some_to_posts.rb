class AddSomeToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :picture, :string
    add_column :posts, :title, :string
  end
end
