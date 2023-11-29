class Post < ApplicationRecord
  has_many :comment
  has_many :like
  belongs_to :author, class_name: 'User'
end
