require 'rails_helper'

RSpec.feature 'User index page', type: :feature do
  before :each do
    @user1 = User.create(name: 'First User',
                         photo: 'https://cdn.pixabay.jpg', bio: 'First user\'s bio', postscounter: 3)
    @user2 = User.create(name: 'Second User',
                         photo: 'https://cdn.pixabay.com.jpg', bio: 'Second user\'s bio', postscounter: 4)
  end

  scenario 'Viewing users information' do
    visit users_path

    # Expect to see the username of all other users
    expect(page).to have_content(@user1.name)
    expect(page).to have_content(@user2.name)

    # Expect to see the profile picture for each user
    expect(page).to have_css("img[src*='#{@user1.photo}']")
    expect(page).to have_css("img[src*='#{@user2.photo}']")

    # Expect to see the number of posts each user has written
    expect(page).to have_content("Number of posts: #{@user1.postscounter}")
    expect(page).to have_content("Number of posts: #{@user2.postscounter}")
  end

  scenario 'Clicking user name' do
    visit users_path
    # Click on a user
    click_link @user1.name

    # Expect to be redirected to the user's show page
    expect(current_path).to eq(user_path(@user1))
    expect(page).to have_content(@user1.name.to_s)
    expect(page).to have_css("img[src*='#{@user1.photo}']")
    expect(page).to have_content("Number of posts: #{@user1.postscounter}")
  end
end
