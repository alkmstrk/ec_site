class Public::OrdersController < ApplicationController
  # アプリケーションコントローラーのtaxメソッド,shipping_costメソッド
  before_action :tax, only: [:confirm]
  before_action :shipping_cost, only: [:confirm, :create]
  def new
    @order = Order.new
  end

  # 購入情報確認画面
  def confirm
    @order = Order.new
    @payment_method = order_params[:payment_method]
    @select_address = order_params[:select_address]
    if @select_address == "3"
      #新しいお届け先を選んでいるのに、フォームがからのとき
      if order_params[:post_code] == "" || order_params[:address] == "" || order_params[:name] == ""
        redirect_to new_order_path, notice: '郵便番号,住所,宛名を全て入力してください'
      else
        order_infos = [order_params[:post_code], order_params[:address], order_params[:name]]
      end
    elsif @select_address == "2"
      address = Address.find(order_params[:address2].to_i)
      order_infos = [address.post_code, address.address, address.name]
    elsif @select_address == "1"
      order_infos = [current_end_user.post_code, current_end_user.address, current_end_user.first_name + current_end_user.last_name]
    end
    #3つの変数に一行で代入
    @post_code, @address, @name = order_infos
  end

  def create
    @order = current_end_user.orders.new(order_params)
    @order.shipping_cost = @shipping_cost
    @order.save
    current_end_user.cart_items.each do |item|
      order_detail = OrderDetail.create(order_id: @order.id, item_id: item.item.id, price: item.item.price, amount: item.amount)
      item.destroy
    end
    redirect_to complete_orders_path
  end

  def complete
  end

  def index
    # N + 1問題のやつ
    @orders = Order.includes(:end_user).all
  end

  def show
    tax
    @order = Order.find(params[:id])
  end

  private
  def order_params
    params.require(:order).permit(:payment_method, :name, :address, :post_code, :address2, :select_address, :total_payment)
  end
end
