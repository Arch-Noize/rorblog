require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:each) do
    @user = User.create(name: 'User', photo: 'image.png', bio: 'Teacher from Mexico.', posts_counter: 0)
    @post = Post.create(author: @user, title: 'Test', text: 'This is a test post', comments_counter: 0, likes_counter: 0)
  end

  context 'when creating a Post' do
    it 'should be valid with valid attributes' do
      expect(@post).to be_valid
      expect(@post.author).to eq(@user)
    end

    it 'should not be valid without a title' do
      @post.title = nil
      expect(@post).to_not be_valid
    end

    it 'should not be valid with the wrong type in counter' do
      @post.comments_counter = 'zero'
      expect(@post).to_not be_valid
    end

    it 'should not be valid with negative numbers' do
      @post.comments_counter = -2
      expect(@post).to_not be_valid
    end
  end

  context 'Most recent comments' do
    before(:each) do
      @user = User.create(name: 'User', photo: 'image.png', bio: 'Teacher from Mexico.', posts_counter: 0)
      @post = Post.create(author: @user, title: 'Test', text: 'This is a test post', comments_counter: 0, likes_counter: 0)
      5.times { |i| Comment.create(post: @post, user: @user, text: (i + 1).to_s) }
    end

    it 'should return the five comments' do
      expect(@post.recent_comments.length).to eq(5)
    end

    it 'should return the most recent comments' do
      expect(@post.recent_comments).to eq(Comment.where(post: @post).order(created_at: :desc).first(5))
    end

    it 'should have the correct amount of comments' do
      @post.recent_comments.each_with_index do |comment, i|
        expect(comment.text).to eq((5 - i).to_s)
      end
    end
  end
end
