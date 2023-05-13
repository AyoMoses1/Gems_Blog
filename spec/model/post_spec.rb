require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) do
    User.create(name: 'Anything', photo: 'http://rrrrrrrr/anything.jpg', bio: 'Anything test', postscounter: 0)
  end

  let(:post) do
    Post.create(author: user, title: 'Hello', text: 'This is my first post')
  end

  subject(:post) do
    described_class.new(
      title: 'Anything',
      text: 'Anything test',
      author: user,
      commentscounter: 0,
      likescounter: 0
    )
  end

  it 'title must not be blank' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'title must not exceed 250 characters' do
    subject.title = 'as' * 300
    expect(subject).to_not be_valid
  end

  it 'commentscounter must be an integer greater than or equal to zero' do
    subject.commentscounter = -1
    expect(subject).to_not be_valid
  end

  it 'likescounter must be an integer greater than or equal to zero' do
    subject.likescounter = -1
    expect(subject).to_not be_valid
  end

  it 'updates user posts counter' do
    subject.save
    expect(user.postscounter).to eq(1)
    Post.create(title: 'Second Anything', text: 'Second Anything test', author: user, commentscounter: 0,
                likescounter: 0)
    expect(user.postscounter).to eq(2)
  end

  it 'returns its five most recent comments' do
    subject.save
    Comment.create(text: 'TEst comments', author: user, post:)
    Comment.create(text: 'TEst comments', author: user, post:)
    Comment.create(text: 'TEst comments', author: user, post:)
    Comment.create(text: 'TEst comments', author: user, post:)
    Comment.create(text: 'TEst comments', author: user, post:)
    expect(subject.five_most_recent_comments.length).to eq(5)
  end
end
