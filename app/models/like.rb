class Like < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :post, class_name: 'Post'

  after_save :update_likes

  private

  def update_likes
    post.update(likes_counter: post.like.count)
  end
end
