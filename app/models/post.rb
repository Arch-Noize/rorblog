class Post < ApplicationRecord
  has_many :comment
  has_many :like
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'

  after_save :update_posts

  def update_posts
    author.increment!(:posts_counter)
  end

  def recent_comments
    Comment.where(post_id: id).order(created_at: :desc).limit(5)
  end
end
