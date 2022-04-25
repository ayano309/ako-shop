class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
  
  acts_as_liker
  has_many :products
  has_many :reviews

  # モジュールの読み込み ページネーション(product.rb& category.rb,user.rb)
  extend DisplayList
  # モジュールの読み込み ユーザーが退会済みかどうかをチェックする(user.rb)
  extend SwitchFlg


  validates :postal_code, presence: true
  validates :prefecture_code, presence: true
  validates :city, presence: true
  validates :street, presence: true

  include JpPrefecture
  jp_prefecture :prefecture_code

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  def update_password(params, *options)
    if params[:password].blank?
      params.delete(:password)
    end

    result = update(params, *options)
    clean_up_passwords
    result
  end

  # postgresの時は::textを入れる
  scope :search_information, -> (keyword) { 
    where("name::text LIKE :keyword OR id::text LIKE :keyword OR email::text LIKE :keyword OR postal_code::text LIKE :keyword OR phone::text LIKE :keyword", keyword: "%#{keyword}%")
  }

  
end
