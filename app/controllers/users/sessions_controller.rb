# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  #before_action :configure_sign_in_params, only: [:create]
  before_action :reject_user, only: [:create]

  def after_sign_in_path_for(resource)
    products_path
  end
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    if self.resource.deleted_flg?
      set_flash_message!(:danger, :deleted_account)
      redirect_to root_path and return
    end
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)

  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to products_path, notice: 'guestuserでログインしました。'
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def reject_user
    @user = User.find_by(email: params[:user][:email].downcase)
    if @user
      if @user.deleted_flg?
        flash[:alert] = '退会済みの会員様です。'
        redirect_to new_user_session_path
      end
    end
  end
end
