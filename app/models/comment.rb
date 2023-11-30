class Comment < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :post, class_name: 'Post'

  after_save :update_comments

  def update_comments
    post.increment!(:comments_counter)
  end
end
