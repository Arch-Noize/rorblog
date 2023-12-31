require 'rails_helper'
RSpec.describe 'Testing Post#index view, it' do
  before :each do
    @user = User.create(name: 'Santiago', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', posts_counter: 0)
    @post1 = Post.create(author_id: @user.id, title: 'Test1', text: 'first post', likes_counter: 0,
                         comments_counter: 0)
    @post2 = Post.create(author_id: @user.id, title: 'Test2', text: 'second post', likes_counter: 0,
                         comments_counter: 0)
    @post3 = Post.create(author_id: @user.id, title: 'Test3', text: 'third post', likes_counter: 0,
                         comments_counter: 0)
    @comment = Comment.create(author_id: @user.id, post_id: @post1.id, text: 'first comment')
    visit user_post_path(@user.id, @post1.id)
  end

  it 'can see the profile picture of the user' do
    visit user_posts_path(@user)
    expect(page).to have_css("img[src*='https://unsplash.com/photos/F_-0BxGuVvo']")
  end

  it 'can see the name of the user' do
    expect(page).to have_content('Santiago')
  end

  it 'can see the number of posts' do
    visit user_posts_path(@user)
    expect(page).to have_content('Number of posts: 3')
  end

  it 'can see the title of a post' do
    expect(page).to have_content('Test1')
  end

  it 'can see the body of a post' do
    expect(page).to have_content('first post')
  end

  it 'can see the first comment on a post' do
    expect(page).to have_content('first comment')
  end

  it 'can see how many comment a post has' do
    expect(page).to have_content('Comments: 1')
  end

  it 'can see how many likes a post has' do
    expect(page).to have_content('Likes: 0')
  end

  it 'should redirect to post/show, when a post is clicked.' do
    within('.post') do
      find('h3', text: 'Test1').click
    end
    expect(page).to have_content('Test1')
  end

  it 'can see the section for pagination.' do
    visit user_path(@user.id)
    expect(page).to have_css('.pagination')
  end
end
