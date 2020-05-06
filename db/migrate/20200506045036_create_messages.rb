class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true
      t.text :content

      t.timestamps
    end
    add_index :messages, [:user_id, :room_id], unique: true
    add_index :messages, [:content, :created_at]
  end
end
