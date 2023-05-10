class AddCommentsRefToPosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :comments_counter, null: false, foreign_key: true
    add_index :posts, :comments_counter
  end
end
