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

    it 'renders post template' do
      expect(response).to render_template(:index)
    end

    it 'post response body includes correct placeholder text' do
      expect(response.body).to include('Here is a list of posts for a given user')
    end
  end

  describe 'GET /show' do
    before do
      get "/users/#{user.id}/posts/#{post.id}"
    end

    it 'returns success for detail post' do
      expect(response).to have_http_status(200)
    end

    it 'renders post detail template' do
      expect(response).to render_template(:show)
    end

    it 'post detail response body includes correct placeholder text' do
      expect(response.body).to include('Here is a post for a given user')
    end
  end
end