class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user

  scope :reviews_with_id, -> { where.not(product_id: nil) }
end
