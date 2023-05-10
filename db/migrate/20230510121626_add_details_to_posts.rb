class AddDetailsToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :title, :string
    add_column :posts, :text, :text
    add_column :users, :comments_counter, :integer
    add_column :users, :likes_counter, :integer
  end
end
