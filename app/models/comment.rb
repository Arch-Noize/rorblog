class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :update_comments

  private

  def update_comments
    post.increment!(:comments_counter)
  end
end
