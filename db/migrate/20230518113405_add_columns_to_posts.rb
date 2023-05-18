class AddColumnsToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :commentscounter, :integer
    add_column :posts, :likescounter, :integer
  end
end
