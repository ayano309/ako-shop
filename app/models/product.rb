class Product < ApplicationRecord
  belongs_to :category
  has_many :reviews
  acts_as_likeable

  # カテゴリによる絞り込み
  # モジュールの読み込み
  extend DisplayList
  

  scope :category_products, -> (category, page) { 
    where(category_id: category).page(page).per(PER)
  }
  
  scope :sort_products, -> (sort_order, page) {
    where(category_id: sort_order[:sort_category]).order(sort_order[:sort]).
    page(page).per(PER)
  }

  scope :sort_list, -> {
    {
      "おすすめ順" => "", 
      "新着順" => "updated_at desc",
      "価格が安い順" => "price asc",
      "価格が高い順" => "price desc"

    }
  }

  def reviews_with_id
    reviews.reviews_with_id
  end
end
