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
    Post.create(author: user, title: 'Hello 1st', text: 'This is my first post')
  end

  let(:second_post) do
    Post.create(author: user, title: 'Hello 2nd', text: 'This is my second post')
  end

  let(:third_post) do
    Post.create(author: user, title: 'Hello 3rd', text: 'This is my third post')
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
    expect(user.most_three_recent_posts).to eq(3)
  end
end