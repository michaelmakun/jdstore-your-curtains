class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def new
    @product = Product.find(params[:product_id])
    @review = Review.new
  end

  def create
    @product = Product.find(params[:product_id])
    @review = Review.new(review_params)
    @review.product = @product
    @review.user = current_user
    if @review.save
      redirect_to product_path(@product)
    else
      flash[:warning] = "评论不得为空"
      redirect_to @product
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
