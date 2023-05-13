require 'rails_helper'

RSpec.describe User, type: :model do
  
  subject(:user) do
    described_class.new(
    name: 'Anything',
    photo: 'http://rrrrrrrr/anything.jpg',
    bio: 'Anything test',
    postscounter: 0
    )
  end

  let(:first_post) do
    Post.create(author: user, title: 'Hello First', text: 'This is my first post', likescounter: 1, commentscounter: 0 )
  end

  let(:second_post) do
    Post.create(author: user, title: 'Hello Second', text: 'This is my second post', likescounter: 2, commentscounter: 0 )
  end

  let(:third_post) do
    Post.create(author: user, title: 'Hello Third', text: 'This is my third post', likescounter: 3, commentscounter: 0 )
  end

  it "name must not be blank" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "postcounter must be an integer greater than or equal to zero" do
    subject.postscounter = -1
    expect(subject).to_not be_valid
  end

  it "returns the three lastest posts of a user" do
    subject.save
    first_post.save
    second_post.save
    third_post.save
    expect(subject.most_three_recent_posts.length).to eq(3)
  end
end