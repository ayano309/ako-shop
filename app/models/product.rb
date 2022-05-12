class Product < ApplicationRecord
  belongs_to :category
  has_many :reviews

  #タグ
  has_many :item_tags, dependent: :destroy
  has_many :tags, through: :item_tags

  acts_as_likeable
  has_one_attached :image

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

  def self.import_csv(file)
    CSV.foreach(file.path, headers: true) do |row|
      # IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
      product = find_by(id: row["id"]) || new
      # CSVからデータを取得し、設定する
      product.attributes = row.to_hash.slice(*updatable_attributes)
      # 保存する
      product.save!(validate: false)
    end
  end
  

  #レビュー(idがあるのだけとってくる)
  def reviews_with_id
    reviews.reviews_with_id
  end


#検索
  def self.search_for(content, method)
    if method == 'patical'
      Product.where('name LIKE ?', '%'+content+'%')
    end
  end

  #タグ
  def save_tags(saveitem_tags)
    # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - saveitem_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = saveitem_tags - current_tags
		
    # 古いタグを消す
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name:old_name)
    end
		
    # 新しいタグを保存
    new_tags.each do |new_name|
      item_tag = Tag.find_or_create_by(name:new_name)
      # 配列に保存
      self.tags << item_tag
    end
  end


  private
    def self.updatable_attributes
      [:name, :description, :price, :recommended_flag, :carriage_flag]
    end
    #名前、商品説明、料金、おすすめフラグ、送料有無フラグ
end
