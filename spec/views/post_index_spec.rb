require 'rails_helper'

RSpec.feature 'User show page', type: :feature do
# Assuming the user post index page is located at '/users/:id/posts'
  describe "User post index page" do
    before :each do
      @user = User.create(name: 'Tom', photo: 'profile.jpg', bio: 'Software Engineer', postscounter: 3)
      @post1 = Post.create(author: @user, title: 'Hi people', text: 'Lorem ipsum dolor', commentscounter: 0, likescounter: 0)
      @post2 = Post.create(author: @user, title: 'Good', text: 'Consectetur adipiscing elit.', commentscounter: 0, likescounter: 0)
      @post3 = Post.create(author: @user, title: 'Dev', text: 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', commentscounter: 0, likescounter: 0)
      visit user_posts_path(@user)
    end

    it "displays the user's profile picture" do
      expect(page).to have_css("img[src*='profile.jpg']")
    end

    it "displays the user's username" do
      expect(page).to have_content(@user.name)
    end

    it "displays the number of posts the user has written" do
      expect(page).to have_content("Number of posts: #{@user.postscounter}")
    end

    it "displays a post's title" do
      expect(page).to have_content(@post1.title)
    end

    it "displays some of the post's body" do
      expect(page).to have_text(@post1.text)
    end

    it "displays the first comment on a post" do
      comment1 = Comment.create(text: 'TEst comments', author: @user, post: @post1)
      visit user_posts_path(@user)
      expect(page).to have_content(comment1.text)
    end

    it "displays the number of comments a post has" do
      comment1 = Comment.create(text: 'TEst comments', author: @user, post: @post2)
      comment1 = Comment.create(text: 'TEst comments', author: @user, post: @post2)
      visit user_posts_path(@user)
      expect(page).to have_content("comments: 2")
    end

    it "displays the number of likes a post has" do
      like1 = Like.create(author: @user, post: @post1)
      like2 = Like.create(author: @user, post: @post1)
      visit user_posts_path(@user)
      expect(page).to have_content("Likes: 2")
    end

    it "displays a section for pagination if there are more posts than fit on the view" do
      expect(page).to have_button('Pagination')
    end

    it "redirects to the post's show page when clicked" do
      click_on "Post ##{@post1.id}"
      expect(current_path).to eq(user_post_path(@user, @post1))
    end
  end


end
