class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy, :favorite]
  PER = 15
  RECOMMEND_PRODUCTS_PER_PAGE = 6

  def index

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
  end

  def show
    @reviews = @product.reviews_with_id
    @review = @reviews.new
    @recommend_products = Product.recommend_products(RECOMMEND_PRODUCTS_PER_PAGE)
  end

  

  
  def destroy
    product = Product.find(params[:id])
    product.destroy
    redirect_to products_path
  end

  def favorite
    current_user.toggle_like!(@product)
    redirect_to product_url @product
  end

  private

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :price, :category_id)
    end

    # def category_params
    #   params[:category].present? ? params[:category] : "none"
    # end

    def sort_params
      params.permit(:sort, :sort_category)
    end
end
