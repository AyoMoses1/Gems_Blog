class AddLikesRefToPosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :likes_counter, null: false, foreign_key: true
    add_index :posts, :likes_counter
  end
end
