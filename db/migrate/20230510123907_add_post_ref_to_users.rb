class AddPostRefToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :post, null: false, foreign_key: true
    # add_index :users, :posts_counter
  end
end
