class AddUserRefToLikes < ActiveRecord::Migration[7.0]
  def change
    add_reference :likes, :user_id, null: false, foreign_key: true
    add_index :likes, :user_id
  end
end
