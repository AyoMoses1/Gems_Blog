require 'rails_helper'

RSpec.feature 'User show page', type: :feature do
  describe 'User post index page' do
    before :each do
      @user = User.create(name: 'Tom', photo: 'profile.jpg', bio: 'Software Engineer', postscounter: 3)
      @post = Post.create(author: @user, title: 'Hi people', text: 'Lorem ipsum', commentscounter: 0, likescounter: 0)
      visit user_post_path(@user, @post)
    end
    it 'displays the post title and who wrote the post' do
      expect(page).to have_content(@post.title)
      expect(page).to have_content(@user.name)
    end
    it 'displays number of likes and comments' do
      expect(page).to have_content('Likes: 0')
      expect(page).to have_content('Comments: 0')
    end
    it 'displays the content of the post' do
      expect(page).to have_content(@post.text)
    end
    scenario 'displays the username of each commentor' do
      @post.comments.each do |comment|
        expect(page).to have_content(comment.author.name)
      end
    end
    scenario 'displays the comments left by each commentor' do
      @post.comments.each do |comment|
        expect(page).to have_content(/Comment:.*#{Regexp.escape(comment.text)}/)
      end
    end
  end
end
