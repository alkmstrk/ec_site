class Public::CartItemsController < ApplicationController
  def index
    tax
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.end_user_id = current_end_user.id
    if @cart_item.save
      redirect_to items_path
    else
      render 'public/items/show'
    end
  end

  def update
    cart_item = CartItem.find(params[:id])
    if cart_item.update(cart_item_params)
      redirect_to cart_items_path
    else
      redirect_to cart_items_path, notice: '変更に失敗しました'
    end
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    if cart_item.destroy
      redirect_to cart_items_path
    else
      redirect_to cart_items_path, notice: '削除に失敗しました'
    end
  end

  def clear
    current_end_user.cart_items.delete_all
    redirect_to cart_items_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
