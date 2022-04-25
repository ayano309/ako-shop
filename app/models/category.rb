class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  # モジュールの読み込み
  extend DisplayList

  scope :request_category, -> (category) { find(category.to_i) }

end
