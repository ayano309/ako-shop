class Product < ApplicationRecord
  belongs_to :category
  has_many :reviews
  acts_as_likeable

  # カテゴリによる絞り込み
  # モジュールの読み込み(product.rb& category.rb,user.rb)

  # PER = 15
  # scope :display_list, -> (page) { page(page).per(PER) }
  extend DisplayList




  # scope :category_products, -> (category, page) {
  #   where(category_id: category).page(page).per(PER)
  # }

  # scope :sort_products, -> (sort_order, page) {
  #   where(category_id: sort_order[:sort_category]).order(sort_order[:sort]).
  #   page(page).per(PER)
  # }
  scope :on_category, -> (category) { where(category_id: category) }
  scope :sort_order, -> (order) { order(order) }

  scope :category_products, -> (category, page) { 
    on_category(category).
    display_list(page)
  }
  
  scope :sort_products, -> (sort_order, page) {
    on_category(sort_order[:sort_category]).
    sort_order(sort_order[:sort]).
    display_list(page)
  }

  scope :sort_list, -> {
    {
      "おすすめ順" => "", 
      "新着順" => "updated_at desc",
      "価格が安い順" => "price asc",
      "価格が高い順" => "price desc"

    }
  }

  # postgresの時は::textを入れる
  scope :search_for_id_and_name, -> (keyword) {
    where("name::text LIKE ?", "%#{keyword}%").
    or(where("id::text LIKE ?", "%#{keyword}%"))
  }  

  #おすすめ商品 flug= trueの商品を取ってくる
  scope :recommend_products, -> (number) { where(recommended_flag: true).take(number) }
  #送料の有無を判定するフラグを取ってくる
  scope :check_products_carriage_list, -> (product_ids) { where(id: product_ids).pluck(:carriage_flag)}

  def reviews_with_id
    reviews.reviews_with_id
  end
end
