class ShoppingCartsController < ApplicationController
before_action :set_cart, only: %i[index create destroy all_destroy]

  def index
    # カートに入っているすべての商品データ
    @user_cart_items = ShoppingCartItem.user_cart_items(@user_cart)
    # user_cart_items カートに入っているすべての商品のデータを返す。
  end

  def show
    @cart = ShoppingCart.find(user_id: current_user)
  end

  def create
    # acts_as_shopping_cartで用意されているaddメソッド
    # to_iは文字列（String）を整数（Integer）に変換するメソッド
    @product = Product.find(product_params[:product_id])
    @user_cart.add(@product, product_params[:price].to_i, product_params[:quantity].to_i)
    redirect_to cart_users_path
  end

  def update

  end

  
  def delete_item
    item = ShoppingCartItem.find(params[:id])
    item.destroy
    redirect_to cart_users_path
  end


  #カートの中身を空にする
  def all_destroy
    user_cart_items = ShoppingCartItem.user_cart_items(@user_cart)
    if user_cart_items.destroy_all
      flash[:notice] = "カート商品を全て削除しました"
      redirect_to cart_users_path
    else
      @user_cart_items = ShoppingCartItem.user_cart_items(@user_cart)
      render :index
    end

  end


  def destroy
    @user_cart.buy_flag = true
    @user_cart.save

    #購入時に決済できるように
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create( 
                          :customer => current_user.token,
                          :amount => @user_cart.total.to_i,
                          :currency => 'jpy'
                        )



    redirect_to cart_users_path
  end

  private
  
  def product_params
    params.permit(:product_id, :price, :quantity)
  end

  def set_cart
    # まだ注文が確定していないカートのデータ
    @user_cart = ShoppingCart.set_user_cart(current_user)
    # set_user_cart まだ注文が確定していないカートのデータを返し、データがなければ新しく作る。
  end
end
