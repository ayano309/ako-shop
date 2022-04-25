class Category < ApplicationRecord
  has_many :products

  PER = 15

  scope :desplay_list, -> (page) {page(page).per(PER) }
  scope :request_category, -> (category) { find(category.to_i) }

end
