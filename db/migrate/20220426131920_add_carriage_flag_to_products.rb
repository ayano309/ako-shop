class AddCarriageFlagToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :carriage_flag, :boolean, default: false
  end
end
