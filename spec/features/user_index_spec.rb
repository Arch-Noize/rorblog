require 'rails_helper'

RSpec.describe 'Testing User#index view, it', type: :feature do
  before :each do
    @user1 = User.create(name: 'Santiago', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', posts_counter: 2)
    @user2 = User.create(name: 'Ben', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', posts_counter: 4)
    @user3 = User.create(name: 'Mike', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', posts_counter: 8)
    visit '/users'
  end

  it 'can see the name of the user' do
    expect(page).to have_content('Santiago')
    expect(page).to have_content('Ben')
    expect(page).to have_content('Mike')
  end

  it 'can see the number of posts each user has written' do
    expect(page).to have_content('Number of posts')
    expect(page).to have_text("Ben\nNumber of posts: 4")
    expect(page).to have_text("Mike\nNumber of posts: 8")
  end

  it 'should return the correct css ' do
    3.times { expect(page).to have_css("img[src*='https://unsplash.com/photos/F_-0BxGuVvo']") }
  end

  it 'should redirect to user/show, when a user is clicked.' do
    click_on 'Santiago'
    expect(page).to have_content 'Santiago'
    expect(current_path).to eq(user_path(@user1))
  end
end
