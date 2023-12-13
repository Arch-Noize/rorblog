require 'rails_helper'
RSpec.describe 'Testing Post#show view, it' do
  before :each do
    @user = User.create(name: 'Santiago', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', posts_counter: 0)
    @post1 = Post.create(author_id: @user.id, title: 'Test1', text: 'first post', likes_counter: 0,
                         comments_counter: 0)
    @post2 = Post.create(author_id: @user.id, title: 'Test2', text: 'second post', likes_counter: 0,
                         comments_counter: 0)
    @post3 = Post.create(author_id: @user.id, title: 'Test3', text: 'third post', likes_counter: 0,
                         comments_counter: 0)
    @comment1 = Comment.create(author_id: @user.id, post_id: @post1.id, text: 'first comment')
    @comment2 = Comment.create(author_id: @user.id, post_id: @post1.id, text: 'second comment')
    visit user_post_path(@user.id, @post1.id)
  end
  it 'should see the post title' do
    expect(page).to have_content('Test1')
  end

  it 'should see who wrote the post' do
    expect(page).to have_content('Santiago')
  end

  it 'should see how many comments it has' do
    expect(page).to have_content('Comments: 2')
  end

  it 'should see how many likes it has' do
    expect(page).to have_content('Likes: 0')
  end

  it 'should see the body of the post' do
    expect(page).to have_content('first post')
  end

  it 'should see the username of each commentor' do
    expect(page).to have_content(@comment1.author.name)
    expect(page).to have_content(@comment2.author.name)
  end

  it 'should see the comment of each commentor left' do
    expect(page).to have_content(@comment1.text)
    expect(page).to have_content(@comment2.text)
  end
end