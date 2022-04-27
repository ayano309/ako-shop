class ShoppingCart < ApplicationRecord
  acts_as_shopping_cart

  # &.lastにより、配列の最後の値を取り出して user_cartに代入してカートの状態を返す
  scope :set_user_cart, -> (user) { user_cart = where(user_id: user.id, buy_flag: false)&.last
    user_cart.nil? ? ShoppingCart.create(user_id: user.id) : user_cart}

  def tax_pct
    0
  end

  # 購入フラグがtrueのものを
  scope :bought_carts, -> { where(buy_flag: true) }
  
  #受注番号検索
  scope :search_carts_by_ids, -> (ids) { where("id::text LIKE ?", "%#{ids}%") }
  #検索した受注番号を持ってくる”＋購入フラグがtrue”
  scope :search_bought_carts_by_ids, -> (ids) { bought_carts.search_carts_by_ids(ids) }

  #購入履歴の一覧  購入フラグがtrueのuser_idが一致したuserを持ってくる
  scope :search_carts_by_user, -> (user) { where(user_id: user) }
  scope :search_bought_carts_by_user, -> (user) { bought_carts.search_carts_by_user(user) }  


  
  #送料 acts_as_shopping_cartはもともとUSD（米ドル）。CARRIAGEという定数に日本円で金額を代入し、その金額を100倍した値を引数として渡す
  CARRIAGE = 400
  FREE_SHIPPING = 0


  # shipping_costメソッドではカート内の商品のcarriage_flagの値を取得し、1つでもtrueの商品が含まれていれば合計金額に送料を加算する
  def shipping_cost
    #カートに入っているアイテムのid
    product_ids = ShoppingCartItem.user_cart_item_ids(self.id)
    #carriage_flagの値を取得する
    products_carriage_list = Product.check_products_carriage_list(product_ids)
    # カート内に1つでも送料ありの商品が含まれていれば、定数CARRIAGEの値が合計金額に加算される
    #Money.newの引数はドルの100分の1であるセント単位で整数を渡しているから100倍にする
    products_carriage_list.include?(true) ? Money.new(CARRIAGE * 100) : Money.new(FREE_SHIPPING)
  end
end
