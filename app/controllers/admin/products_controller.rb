class Admin::ProductsController < AdminController

  def index
    if params[:category].blank?
      @products = Product.all.recent
    else
      # @category_id = Category.find_by(name: params[:category]).id
      @products = Product.where(category_id: params[:category]).recent
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
    @categories = Category.all.map { |c| [c.name, c.id] }
  end

  def create
    @product = Product.new(product_params)
    @product.category_id = params[:category_id]
    if @product.save
      redirect_to admin_products_path
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
    @categories = Category.all.map { |c| [c.name, c.id] }
    @product.category_id = params[:category_id]
  end

  def update
    @product = Product.find(params[:id])
    @product.category_id = params[:category_id]
    if @product.update(product_params)
      redirect_to admin_products_path, notice: "产品更新成功!!!"
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to admin_products_path, alert: "删除产品成功!!!"
  end

  private

  def product_params
    params.require(:product).permit(:title,:description,:price,:quantity, :image, :category_id)
  end
end
