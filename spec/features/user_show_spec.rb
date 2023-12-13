require 'rails_helper'
RSpec.describe 'Testing User#show view, it' do
  before :each do
    @user = User.create(name: 'Santiago', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'bio test',
                        posts_counter: 0)
    @post1 = Post.create(author_id: @user.id, title: 'Test1', text: 'first post', likes_counter: 0,
                         comments_counter: 0)
    @post2 = Post.create(author_id: @user.id, title: 'Test2', text: 'second post', likes_counter: 0,
                         comments_counter: 0)
    @post3 = Post.create(author_id: @user.id, title: 'Test3', text: 'third post', likes_counter: 0,
                         comments_counter: 0)
    @comment = Comment.create(author_id: @user.id, post_id: @post1.id, text: 'first comment')
    visit user_path(@user.id)
  end
  it 'should see the profile picture of the user' do
    expect(page).to have_css("img[src*='https://unsplash.com/photos/F_-0BxGuVvo']")
  end

  it 'should see the user profile name' do
    expect(page).to have_content('Santiago')
  end

  it 'should see the number of posts user has written' do
    expect(page).to have_content('Number of posts: 3')
  end

  it 'should see the user bio ' do
    expect(page).to have_content('bio test')
  end

  it 'should see the user first three posts ' do
    expect(page).to have_content('first post')
    expect(page).to have_content('second post')
    expect(page).to have_content('third post')
  end

  it 'should see the button that let me view all users posts' do
    expect(page).to have_link('See all posts')
  end

  it "should redirect to post/show, when a post is clicked." do
    click_on 'Test1'
    expect(page).to have_content 'first post'
    expect(current_path).to eq(user_post_path(@user, @post1))
  end

  it "should redirect to post/index, when a button is clicked. " do
    within('.pagination') do
      find_link('See all posts').click
    end
    expect(current_path).to eq(user_posts_path(@user.id))
  end
end
