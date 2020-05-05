class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :content

      t.timestamps
    end
    add_index :comments, [:content, :created_at], unique: true
  end
end
