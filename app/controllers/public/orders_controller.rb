class Public::OrdersController < ApplicationController
  # アプリケーションコントローラーのtaxメソッド,shipping_costメソッド
  before_action :tax, only: [:confirm, :show]
  before_action :shipping_cost, only: [:confirm, :create]
  before_action :set_order_new, only: [:new, :confirm ]
  before_action :set_order, only: [:show]

  def index
    @orders = Order.includes(:end_user).all # N + 1問題のやつ
  end

  def confirm  # 購入情報確認画面
    if order_params[:select_address] == "3"
      address_form_check # 新しいお届け先を選んでいるのに、フォームがからのとき
    elsif order_params[:select_address] == "2"
      address = Address.find(order_params[:address_id].to_i)
      @order_infos = address.address_infos # address.rbに配列を作るメソッドを定義
    elsif order_params[:select_address] == "1"
      @order_infos = current_end_user.user_infos # end_user.rbに情報の配列を作るメソッドを記述
    end
    @post_code, @address, @name = @order_infos #3つの変数に一行で代入(配列を渡してもいい感じに代入してくれる)
    @payment_method = order_params[:payment_method]
  end

  def create
    @order = current_end_user.orders.new(order_params.merge(:shipping_cost => @shipping_cost))
    # order.rbに購入処理のメソッドを記述(order_complete)
    @order.order_complete(current_end_user) ? (redirect_to complete_orders_path) : (redirect_to cart_items_path, notice: '購入に失敗しました')
    # if @order.order_complete(current_end_user)
    #   redirect_to complete_orders_path
    # else
    #   redirect_to cart_items_path, notice: '購入に失敗しました'
    # end
  end

  private
  def order_params
    params.require(:order).permit(:payment_method, :name, :address, :post_code, :address_id, :select_address, :total_payment)
  end

  def set_order_new
    @order = Order.new
  end

  #新しいお届け先を選んでいるのに、フォームがからのとき
  def address_form_check
    # ここで配列も作ってしまう。条件式を短くするため。インスタンス変数にしないと、confirmで使えない
    @order_infos = [order_params[:post_code], order_params[:address], order_params[:name]]
    # 配列からnilと空文字を削除して、空文字があるかどうか判定。include?("")だとスペース入ってるときに対応できない
    if @order_infos.reject(&:blank?).length < 3
    # if (order_params[:post_code].present?) || (order_params[:address].present?) || (order_params[:name].present?)
      redirect_to new_order_path, notice: '郵便番号,住所,宛名を全て入力してください'
    end
  end

end
