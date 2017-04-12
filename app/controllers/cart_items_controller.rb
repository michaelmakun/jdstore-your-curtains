class CartItemsController < ApplicationController
  before_action :authenticate_user!
  respond_to :js

  def destroy
    @cart = current_cart
    @cart_item = @cart.cart_items.find_by(params[:id])
    # @product = @cart_item.product
    @cart_item.destroy

    flash[:warning] = "成功从购物车删除#{@cart_item.title}产品"
    redirect_to carts_path
  end

  def update
    p params
    @cart = current_cart
    @cart_item = @cart.cart_items.find_by(product_id: params[:id])
    if @cart_item.product.quantity >= cart_item_params[:quantity].to_i
      if params[:add] == "1"
        if @cart_item.quantity < @cart_item.product.quantity
           @cart_item.quantity +=1
           @cart_item.product.quantity -= 1
           @cart_item.save
        elsif @cart_item.quantity == @cart_item.product.quantity
           flash[:alert] = "数量不足以加入购物车"
        end
      elsif params[:sub] == "1"
        if @cart_item.quantity > 0
          @cart_item.quantity -= 1
          @cart_item.product.quantity += 1
          @cart_item.save
        elsif @cart_item.quantity = 0
          flash[:notice] = "商品数量至少为1"
        end
      end
    else
      flash[:warning] = "数量不足以加入购物车"
    end
    redirect_to carts_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end
