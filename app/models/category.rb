class Category < ApplicationRecord
  has_many :products

  scope :request_category, -> (category) { find(category.to_i) }
end
