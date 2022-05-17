class AddSoldoutFlagToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :soldout_flag, :boolean, default: false
  end
end
