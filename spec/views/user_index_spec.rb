require 'rails_helper'

RSpec.feature 'User Index Page', type: :feature do
  scenario 'Viewing user information' do
    # Create some test data
    user1 = User.create( name: 'First User', photo: 'https://cdn.pixabay.com/photo/2016/12/23/12/40/night-1927265_640.jpg', bio: 'First user\'s bio', postscounter: 3)
    user2 = User.create( name: 'Second User', photo: 'https://cdn.pixabay.com/photo/2017/03/17/04/07/woman-2150881_640.jpg', bio: 'Second user\'s bio', postscounter: 4)

    visit users_path

    # Expect to see the username of all other users
    expect(page).to have_content(user1.name)
    expect(page).to have_content(user2.name)

    # Expect to see the profile picture for each user
    expect(page).to have_css("img[src*='#{user1.photo}']")
    expect(page).to have_css("img[src*='#{user2.photo}']")

    # Expect to see the number of posts each user has written
    expect(page).to have_content("Number of posts: #{user1.postscounter}")
    expect(page).to have_content("Number of posts: #{user2.postscounter}")
  end
end
