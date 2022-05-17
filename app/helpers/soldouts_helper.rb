module SoldoutsHelper
  def add_active_class
    'active' if @product.soldout_flag
  end
end
