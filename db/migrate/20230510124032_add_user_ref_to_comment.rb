class AddUserRefToComments < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :user_id, null: false, foreign_key: true
    add_index :comments, :user_id
  end
end
