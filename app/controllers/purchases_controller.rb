class PurchasesController < ApplicationController
  before_action :set_user
  before_action :authenticate_user!

  #購入履歴

  def index
    @orders = ShoppingCart.search_bought_carts_by_user(@user).page(params[:page]).per(15)
  end

  def show
    # カートの中に入っているものを取ってくる
    @cart = ShoppingCart.find(params[:num])
    @cart_items = ShoppingCartItem.user_cart_items(@cart.id)
  end

  private

  def set_user
    @user = current_user
  end
end
