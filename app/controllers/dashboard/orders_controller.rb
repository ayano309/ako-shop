class Dashboard::OrdersController < ApplicationController
  before_action :authenticate_admin!
  layout 'dashboard/dashboard'

  def index
    if params[:code].present?
      #検索した受注番号がある商品
      @orders = ShoppingCart.search_bought_carts_by_ids(params[:code]).page(params[:page]).per(15)
    else
      #購入フラグがtrueの商品
      @orders = ShoppingCart.bought_carts.page(params[:page]).per(15)
    end
  end

  def show
    @cart = ShoppingCart.find(params[:id])
    @cart_items = ShoppingCartItem.user_cart_items(@cart.id)
  end
end
