class Like < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User'

  after_save :update_post_like_counter

  private
  
  def update_post_like_counter
    post.increment(:likescounter)
  end
end
