class Comment < ApplicationRecord
  belongs_to :post
  validates :comment, :body, presence: true
end
