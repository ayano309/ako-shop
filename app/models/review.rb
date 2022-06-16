class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user
  
  validates :content, presence: true
  scope :reviews_with_id, -> { where.not(product_id: nil) }
end
