require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.create(name: 'User', photo: 'image.png', bio: 'Teacher from Mexico.', posts_counter: 0)
  end

  context 'when creating a User' do
    it 'should be valid with valid attributes' do
      expect(@user).to be_valid
      expect(User.name).to eq('User')
    end

    it 'should not be valid without a name' do
      @user.name = nil
      expect(@user).to_not be_valid
    end

    it 'should not be valid with the wrong type in counter' do
      @user.posts_counter = 'zero'
      expect(@user).to_not be_valid
    end

    it 'should not be valid with negative numbers' do
      @user.posts_counter = -2
      expect(@user).to_not be_valid
    end
  end

  context 'Most recent posts' do
    before(:each) do
      @user = User.create(name: 'User', photo: 'image.png', bio: 'Teacher from Mexico.', posts_counter: 0)
      5.times { |i| Post.create(author: @user, title: 'This is a post', comments_counter: (i + 1), likes_counter: 0) }
    end

    it 'should return the three posts' do
      expect(@user.recent_posts.length).to eq(3)
    end

    it 'should return the most recent posts' do
      expect(@user.recent_posts).to eq(Post.where(author: @user).order(created_at: :desc).first(3))
    end

    it 'should have the correct amount of comments' do
      expect(@user.recent_posts[0].comments_counter).to eq(5)
      expect(@user.recent_posts[1].comments_counter).to eq(4)
      expect(@user.recent_posts[2].comments_counter).to eq(3)
    end
  end
end
