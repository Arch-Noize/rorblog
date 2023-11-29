class User < ApplicationRecord
  has_many :post, foreign_key: 'author_id'
  has_many :comment, foreign_key: 'author_id'
  has_many :like, foreign_key: 'author_id'
end
