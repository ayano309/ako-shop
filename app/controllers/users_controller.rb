class UsersController < ApplicationController
  before_action :set_user

  def show
    
  end

  def mypage
  
  end

  private

    def set_user
      @user = current_user
    end

    def user_params
      prams.permit(:name, :postal_code, :prefecture_code, :city, :street, :other_address, :phone, :email, :password)
    end
end
