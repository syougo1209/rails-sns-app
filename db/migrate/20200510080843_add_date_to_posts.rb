class AddDateToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :created_date, :string
  end
end
