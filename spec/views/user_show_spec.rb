require 'rails_helper'

RSpec.feature 'User show page', type: :feature do
  before :each do
    @user = User.create(name: 'Tom', photo: 'profile.jpg', bio: 'Software Engineer', postscounter: 3)
    Post.create(author: @user, title: 'Hi people', text: 'Lorem ipsum dolor sit amet.', commentscounter: 0, likescounter: 0)
    Post.create(author: @user, title: 'Good', text: 'Consectetur adipiscing elit.', commentscounter: 0, likescounter: 0)
    Post.create(author: @user, title: 'Dev', text: 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', commentscounter: 0, likescounter: 0)
  end

  scenario 'displays user information correctly' do
    visit user_path(@user.id)

    expect(page).to have_css("img[src*='profile.jpg']")
    expect(page).to have_content(@user.name)
    expect(page).to have_content("Number of posts: 6")
    expect(page).to have_content(@user.bio)
  end

  scenario 'displays user\'s three latest posts' do
    visit user_path(@user.id)
    @user.posts.limit(3).each do |post|
      expect(page).to have_content(post.title)
    end
  end

  scenario 'can view a user\'s post' do
    post = Post.create(author: @user, title: 'Hi people', text: 'Lorem ipsum dolor sit amet.', commentscounter: 0, likescounter: 0)
    visit user_path(@user)
    click_link "Post \##{post.id}"

    expect(current_path).to eq(user_post_path(@user, post))
  end

  scenario 'can view all of a user\'s posts' do
    visit user_path(@user)
    click_link 'See all posts'

    expect(current_path).to eq(user_posts_path(@user))
  end

end
