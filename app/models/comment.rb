class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :update_post_comment_counter

  private

  def update_post_comment_counter
    post.increment!(:commentscounter)
  end
end
