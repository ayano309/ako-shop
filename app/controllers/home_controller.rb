class HomeController < ApplicationController
  def top
    if sort_params.present?
      @category = Category.request_category(sort_params[:sort_category])
      @products = Product.sort_products(sort_params, params[:page])
    elsif params[:category].present?
      @category = Category.request_category(params[:category])
      @products = Product.category_products(@category, params[:page])
    else
      @products = Product.display_list(params[:page])
    end
    #1 sort_paramsが存在する（並び替えをしたとき）
    #2 sort_paramsは存在しないが、params[:category]が存在する（カテゴリを選択したとき）
    #3 どちらも存在しない（indexページにアクセスしたとき）

    @categories = Category.all
    @sort_list = Product.sort_list

    @rank_products = Product.find(ShoppingCartItem.group(:item_id).order('count(item_id) desc').limit(5).pluck(:item_id))
  end

  def about; end
  
  def terms; end

  def privacy; end


  private
  def sort_params
    params.permit(:sort, :sort_category)
  end
end
