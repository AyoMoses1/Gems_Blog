require 'rails_helper'

RSpec.feature 'User show page', type: :feature do
  describe 'User post index page' do
    before :each do
      @user = User.create(name: 'Tom', photo: 'profile.jpg', bio: 'Software Engineer', postscounter: 3)
      @post1 = Post.create(author: @user, title: 'Hi people', text: 'Lorem', commentscounter: 0, likescounter: 0)
      visit user_posts_path(@user)
    end
    it "displays the user's data" do
      expect(page).to have_css("img[src*='profile.jpg']")
      expect(page).to have_content(@user.name)
      expect(page).to have_content("Number of posts: #{@user.postscounter}")
    end
    it "displays a post's title and some of its body" do
      expect(page).to have_content(@post1.title)
      expect(page).to have_text(@post1.text)
    end
    it 'displays the first comment on a post and the number of comments and likes a post has' do
      test_comment = Comment.create(text: 'Test comments', author: @user, post: @post1)
      Like.create(author: @user, post: @post1)
      visit user_posts_path(@user)
      expect(page).to have_content(test_comment.text)
      expect(page).to have_content('comments: 1')
      expect(page).to have_content('Likes: 1')
    end
    it "displays a section for pagination and redirects to the post's show page when a post is clicked" do
      expect(page).to have_button('Pagination')
      click_on "Post ##{@post1.id}"
      expect(current_path).to eq(user_post_path(@user, @post1))
    end
  end
end
