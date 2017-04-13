class Admin::ProductsController < AdminController

  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    if params[:category].blank?
      @products = Product.all.recent
    else
      # @category_id = Category.find_by(name: params[:category]).id
      @products = Product.where(category_id: params[:category]).recent
    end
  end

  def show
    @photos = @product.photos.all
  end

  def new
    @product = Product.new
    @categories = Category.all.map { |c| [c.name, c.id] }
    @photo = @product.photos.build   #上传多图用
  end

  def create
    @product = Product.new(product_params)
    @product.category_id = params[:category_id]
    if @product.save
      if params[:photos] != nil
        params[:photos]['avatar'].each do |a|
          @photo = @product.photos.create(:avatar => a)
        end
      end
      redirect_to admin_products_path
    else
      render :new
    end
  end

  def edit
    @categories = Category.all.map { |c| [c.name, c.id] }
    @product.category_id = params[:category_id]
  end

  def update
    @product.category_id = params[:category_id]
    if params[:photos] != nil
      @product.photos.destroy_all #need to destroy old pics first

      params[:photos]['avatar'].each do |a|
        @photo = @product.photos.create!(:avatar => a )
      end

      @product.update(product_params)
      redirect_to admin_products_path, notice: "产品带图片更新成功!!!"
    elsif @product.update(product_params)
      redirect_to admin_products_path, notice: "产品更新成功"
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to admin_products_path, alert: "删除产品成功!!!"
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title,:description,:price,:quantity, :image, :category_id)
  end
end
