class Admin < ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable
  # deviseのログイン機能とバリデーション機能だけが有効

  def self.guest
    find_or_create_by!(name: 'guestadmin' ,email: 'admin@example.com') do |admin|
      admin.password = SecureRandom.urlsafe_base64
      admin.name = "guestadmin"
    end
  end
end
