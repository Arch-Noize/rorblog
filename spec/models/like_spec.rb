require 'rails_helper'

RSpec.describe Like, type: :model do
  before(:each) do
    @user = User.create(name: 'User', photo: 'image.png', bio: 'Teacher from Mexico.', posts_counter: 0)
    @post = Post.create(author: @user, title: 'Test', text: 'This is a test post', comments_counter: 0,
                        likes_counter: 0)
    @like = Like.create(user: @user, post: @post)
  end

  context 'when creating a Like' do
    it 'is valid with the existing user and the post' do
      expect(@like).to be_valid
    end

    it 'is not valid without the post' do
      @like.post = nil
      expect(@like).to_not be_valid
    end

    it 'is not valid without the user' do
      @like.user = nil
      expect(@like).to_not be_valid
    end
  end

  context 'Updating likes' do
    before(:each) do
      7.times { Like.create(user: @user, post: @post) }
    end

    it 'keeps track of likes and equals to 8' do
      expect(@post.likes_counter).to eq(8)
    end
  end
end
