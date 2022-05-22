class Admin < ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable
  # deviseのログイン機能とバリデーション機能だけが有効
end
