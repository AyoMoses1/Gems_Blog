class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes
  has_many :comments

  after_save :update_user_post_counter

  private
  
  def update_user_post_counter
    author.increment!(:postscounter)
  end

  def five_most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
