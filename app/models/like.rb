class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  belongs_to :post, class_name: 'Post'

  after_save :update_likes

  def update_likes
    post.update(likes_counter: post.likes.count)
  end
end
