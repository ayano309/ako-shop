class AddRecommendedFlagToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :recommended_flag, :boolean, default: false
  end
end
