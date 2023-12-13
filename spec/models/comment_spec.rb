require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:each) do
    @user = User.create(name: 'User', photo: 'image.png', bio: 'Teacher from Mexico.', posts_counter: 0)
    @post = Post.create(author: @user, title: 'Test', text: 'This is a test post', comments_counter: 0,
                        likes_counter: 0)
    @comment = Comment.create(post: @post, author: @user, text: 'This is a comment')
  end

  context 'when creating a Comment' do
    it 'is valid with the existing user and the post' do
      expect(@comment).to be_valid
    end

    it 'is not valid without the post' do
      @comment.post = nil
      expect(@comment).to_not be_valid
    end

    it 'is not valid without the user' do
      @comment.author = nil
      expect(@comment).to_not be_valid
    end
  end

  context 'Updating comments' do
    before(:each) do
      7.times { |i| Comment.create(author: @user, post: @post, text: (i + 1).to_s) }
    end

    it 'keeps track of likes and equals to 8' do
      expect(@post.comments_counter).to eq(8)
    end
  end
end
