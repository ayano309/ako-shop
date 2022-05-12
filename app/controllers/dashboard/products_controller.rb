class Dashboard::ProductsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_product, only: %w[show edit update destroy]
  layout "dashboard/dashboard"

  def index
    @sorted = ""
    @sort_list = Product.sort_list

    if params[:sort].present?
      @sorted = params[:sort]
    end

    if params[:keyword].present?
      keyword = params[:keyword].strip
      @total_count = Product.search_for_id_and_name(keyword).count
      @products = Product.search_for_id_and_name(keyword).display_list(params[:pages])
    else      
      @total_count = Product.count
      @products = Product.sort_order(@sorted).display_list(params[:page])
    end
  end

  def new
    @product = Product.new
    @categories = Category.all
  end

  def create
    @product = Product.new(product_params)
    tag_list = params[:product][:tag_name].split(',')
    
    if @product.save
      @product.save_tags(tag_list)
      redirect_to dashboard_products_path
    else
      render :new
    end
  end

  def edit
    @categories = Category.all
  end

  def update
    @product.update(product_params)
    redirect_to dashboard_products_path
  end

  def destroy
    @product.destroy
    redirect_to dashboard_products_path
  end

  #表示用、get
  def import
  end

  #import、post
  def import_csv
    Product.import_csv(params[:file])
    redirect_to import_csv_dashboard_products_path
  end

  #雛形ダウンロード用
  def download_csv
    send_file(
      "#{Rails.root}/public/csv/products.csv",
      filename: "products.csv",
      type: :csv
    )
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end
    # おすすめ商品かどうかを判定するフラグ
    def product_params
      params.require(:product).permit(:name, :description, :price, :recommended_flag, :carriage_flag, :category_id, :image)
    end
end