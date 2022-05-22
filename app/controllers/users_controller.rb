class UsersController < ApplicationController
  before_action :set_user
  before_action :authenticate_user!

  def show

  end

  def mypage

  end

  def update_pasword
    if password_set?
      @user.update_password(user_params)
      flash[:notice] = 'パスワードは正しく変更されました'
      redirect_to root_path
    else
      @user.errors.add(:password,'パスワードに不備があります。')
      render 'edit_password'
    end
  end

  def edit_password
  end

  def favorite
    @favorites = @user.likees(Product)
  end

  def destroy
    # ユーザーが退会処理をするとき
    @user.deleted_flg = User.switch_flg(@user.deleted_flg)
    @user.update(deleted_flg: @user.deleted_flg)
    redirect_to mypage_users_path
  end

  #カード登録、更新画面
  def register_card
    # API秘密鍵を呼び出す
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    @count = 0
    card_info = {}

    # ログインユーザーのクレジットカード情報からPay.jpに登録されているカスタマー情報を引き出す
    if @user.token != ''
      result = Payjp::Customer.retrieve(@user.token).cards.all(limit: 1).data[0]
      @count = Payjp::Customer.retrieve(@user.token).cards.all.count

      #カード情報取得 last4はカード番号下４桁
      card_info[:brand] = result.brand
      card_info[:exp_month] = result.exp_month
      card_info[:exp_year] = result.exp_year
      card_info[:last4] = result.last4
    end

    @card = card_info
  end

  #カードcreate
  def token
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    customer = @user.token

    if @user.token != ''
      cu = Payjp::Customer.retrieve(customer)
      delete_card = cu.cards.retrieve(cu.cards.data[0]['id'])
      delete_card.delete
      cu.cards.create(:card => params['payjp-token'])
    else
      cu = Payjp::Customer.create
      cu.cards.create(:card => params['payjp-token'])
      @user.token = cu.id
      @user.save
    end
    redirect_to mypage_users_path
  end

  private

    def set_user
      @user = current_user
    end

    def user_params
      prams.permit(:name, :postal_code, :prefecture_code, :city, :street, :other_address, :phone, :email, :password)
    end

    def password_set?
      user_params[:password].present?  ? true : false
    end
end
