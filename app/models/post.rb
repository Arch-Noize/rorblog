class Post < ApplicationRecord
  has_many :comments, dependent: :destroy, counter_cache: true
  has_many :likes
  belongs_to :author, class_name: 'User'

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_initialize :set_defaults
  after_save :update_posts

  def recent_comments
    Comment.where(post_id: id).order(created_at: :desc).limit(5)
  end

  private

  def set_defaults
    self.comments_counter ||= 0
    self.likes_counter ||= 0
  end

  def update_posts
    author.increment!(:posts_counter)
  end
end
