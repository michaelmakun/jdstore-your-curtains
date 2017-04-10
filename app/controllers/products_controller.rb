class ProductsController < ApplicationController
  before_action :validate_search_key, only: [:search]
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @products = Product.all.recent
    if params[:category].present?
      # @category_id = Category.find_by(name: params[:category]).id
      @products = Product.where(category_id: params[:category]).recent
    elsif params[:favorite] == "success"
      @products = current_user.favorite_products
    elsif params[:order] == "by_product_quantity"
      @products = Product.all.order("quantity DESC")
    elsif params[:order] == "by_product_price"
      @products = Product.all.order("price ASC")
    end
  end

  def show
    @product = Product.find(params[:id])
    @reviews = @product.reviews.all.order("created_at DESC")
    @review = Review.new

    if @reviews.blank?
      @avg_review = 0
    else
      @avg_review = @reviews.average(:rating).present? ? @reviews.average(:rating).round(2) : 0
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to products_path
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path
  end

  def add_to_cart
    @product = Product.find(params[:id])
    if !current_cart.products.include?(@product)
      current_cart.add_product_to_cart(@product)
      flash[:notice] = "你已成功将 #{@product.title} 加入购物车"
    else
      flash[:warning] = "你的购物车内已有此物品"
    end
    redirect_to product_path(@product)
  end

  def add_favorite
    @product = Product.find(params[:id])
    if !current_user.favorite_product?(@product)
      current_user.favorite!(@product)
      flash[:notice] = "收藏#{@product.title}成功"
    else
      flash[:warning] = "您已收藏过该产品"
    end
    redirect_to :back
  end

  def cancel_favorite
    @product = Product.find(params[:id])
    if current_user.favorite_product?(@product)
      current_user.unfavorite!(@product)
      flash[:alert] = "取消收藏#{@product.title}成功"
    else
      flash[:warning] = "本来就没有收藏，不用取消"
    end
    redirect_to :back
  end

  def search
    if @query_string.present?
      @products = search_params
    end
  end

  protected

  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price)
  end

  def search_params
    Product.ransack({:title_or_description_cont => @query_string}).result(distinct: true)
  end
end
