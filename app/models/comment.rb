class Comment < ApplicationRecord
  belongs_to :post
  validates :comment, presence: true
  validates :body, presence: true
end
