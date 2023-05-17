require 'rails_helper'

describe 'GET /users' do

  before do
    get '/users'
  end
  
  scenario 'returns the correct status' do 
    expect(response.status).to eq(200)
  end

  scenario 'renders the correct template' do
    expect(response).to render_template(:index)
  end

  scenario 'returns correct placeholder text in the response body' do
    expect(response.body).to include("Here is a list of all users")
  end

end

describe 'GET /show' do

  
  let!(:user) do
    User.create(
      name: 'Rails',
      photo: 'http://rrrrrr.png',
      bio: 'Testing',
      postscounter: 20
    )
  end
  
  before do
    get "/users/#{user.id}"
  end

  scenario 'returns the correct status' do 
    expect(response.status).to eq(200)
  end

  scenario 'renders the correct template' do
    expect(response).to render_template(:show)
  end

  scenario 'returns correct placeholder text in the response body' do
    expect(response.body).to include('Here is the details of a user')
  end
end