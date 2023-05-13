require 'rails_helper'

RSpec.describe User, type: :model do
  
  subject do
    described_class.new(
    name: 'Anything',
    photo: 'http://rrrrrrrr/anything.jpg',
    bio: 'Anything test',
    postscounter: 0
    )
  end

  it "name must not be blank" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "postcounter must be an integer greater than or equal to zero" do
    subject.postscounter = -1
    expect(subject).to_not be_valid
  end
end