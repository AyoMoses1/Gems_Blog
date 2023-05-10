class AddPostsRefToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :posts_counter, null: false, foreign_key: true
    add_index :users, :posts_counter
  end
end
