require 'rails_helper'

RSpec.describe 'Users', type: :request do
  context 'Test /index' do
    before :each do
      get '/users/'
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

    it 'renders placeholder text correctly' do
      expect(response.body).to include('<h1>In this section, show a list of users.</h1>')
    end
  end

  context 'Test /show' do
    let(:user) { User.create(name: 'User', photo: 'image.png', bio: 'Test.', posts_counter: 0) }
    before :each do
      get "/users/#{user.id}"
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

    it 'renders placeholder text correctly' do
      expect(response.body).to include('<h1>In this section, show a selected user from the list.</h1>')
    end
  end
end
