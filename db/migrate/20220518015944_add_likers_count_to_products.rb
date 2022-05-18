class AddLikersCountToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :likers_count, :integer, default: 0
  end
end
