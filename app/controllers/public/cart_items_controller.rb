class Public::CartItemsController < ApplicationController
  before_action :tax, only: :index

  def create
    @cart_item = current_end_user.cart_items.new(cart_item_params)
    # add_item?の結果(true,false)を待つ
    # returnがないと、処理が先に進んでいってしまう?なんせreturnは
    add_item? and return
    flash[:notice] = '追加に失敗しました' unless @cart_item.save
    redirect_to items_path
  end

  def update
    cart_item = CartItem.find(params[:id])
    flash[:notice] = '変更に失敗しました' unless cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    flash[:notice] = '削除に失敗しました' unless cart_item.destroy
    redirect_to cart_items_path
  end

  def clear
    current_end_user.cart_items.delete_all
    redirect_to cart_items_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

  # カートに追加済みか判定してredirect
  # ここで判定だけさせて、createアクションでreirect_toさせればreturnなんて使わなくていい
  def add_item?
    if current_end_user.cart_items.where(item_id: @cart_item.item_id).exists?
      # redirect_to,renderはtrueを返す
      redirect_to cart_items_path, notice: 'すでに追加しています'
    end
  end

end
