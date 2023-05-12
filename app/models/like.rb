class Like < ApplicationRecord
  belongs_to :post 
  belongs_to :post class_name: "User"

  def update_post_like_counter
    post.increment(:likescounter)
  end
end