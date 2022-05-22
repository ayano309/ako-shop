class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def index
    @product = Product.find(params[:product_id])
    @reviews = @product.reviews_with_id
    @review = @reviews.new
  end

  def create
    product = Product.find(params[:product_id])
    review = product.reviews.build(review_params)
    review.user_id = current_user.id
    review.save
    redirect_to product_reviews_path(product)

  end

  private
  def review_params
    params.require(:review).permit(:content, :rate)
  end
end
