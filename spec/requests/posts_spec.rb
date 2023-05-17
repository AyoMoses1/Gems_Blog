require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let!(:user) do
    User.create(
      name: 'Rails',
      photo: 'http://rrrrrr.png',
      bio: 'Testing',
      postscounter: 20
    )
  end

  let!(:post) do
    Post.create(
      title: 'Ruby',
      text: 'Ruby is awesome',
      author: user,
      commentscounter: 20,
      likescounter: 20
    )
  end

  describe 'GET /index' do
    before do
      get "/users/#{user.id}/posts/"
    end

    scenario 'returns the correct status' do 
      expect(response.status).to eq(200)
    end
  
    scenario 'renders the correct template' do
      expect(response).to render_template(:index)
    end
  
    scenario 'returns correct placeholder text in the response body' do
      expect(response.body).to include('Here is a list of posts for a given user')
    end
  end

  describe 'GET /show' do
    before do
      get "/users/#{user.id}/posts/#{post.id}"
    end

    scenario 'returns the correct status' do 
      expect(response.status).to eq(200)
    end
  
    scenario 'renders the correct template' do
      expect(response).to render_template(:show)
    end
  
    scenario 'returns correct placeholder text in the response body' do
      expect(response.body).to include('Here is a post for a given user')
    end
  end
end