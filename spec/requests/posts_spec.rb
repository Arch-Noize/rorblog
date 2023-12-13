require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  context 'Testing /index' do
    let(:user) { User.create(name: 'User', photo: 'image.png', bio: 'Test.', posts_counter: 0) }
    let(:post) do
      Post.create(author: user, title: 'Test', text: 'This is a test.', comments_counter: 0,
                  likes_counter: 0)
    end

    before :each do
      get "/users/#{user.id}/posts"
    end

    it 'returns successful response if status is correct' do
      expect(response).to be_successful
    end

    it 'returns HTTP status 200 if response status is correct' do
      expect(response.status).to eq(200)
    end

    it 'renders the correct view file' do
      expect(response).to render_template(:index)
    end
  end

  context 'Testing /show' do
    let(:user) { User.create(name: 'User', photo: 'image.png', bio: 'Test.', posts_counter: 0) }
    let(:post) do
      Post.create(author: user, title: 'Test', text: 'This is a test.', comments_counter: 0,
                  likes_counter: 0)
    end

    before :each do
      get "/users/:user_id/posts/#{post.id}"
    end

    it 'returns successful response if status is correct' do
      expect(response).to be_successful
    end

    it 'returns HTTP status 200 if response status is correct' do
      expect(response.status).to eq(200)
    end

    it 'renders the correct view file' do
      expect(response).to render_template(:show)
    end

    it 'renders text correctly' do
      expect(response.body).to include('<h3>Test by User</h3>')
    end
  end
end
