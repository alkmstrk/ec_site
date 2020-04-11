class Admin::OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update]

  def index
    @orders = Order.all
    @total_amount = 0
  end

  def show
    shipping_cost
    tax
  end

  def update
    @order.update(order_params)
    @order.order_details.update_all(making_status: "制作待ち") if @order.order_status == "入金確認"
    redirect_to admin_order_path(@order)
  end

  def detail_update
    @detail = OrderDetail.find(params[:order_detail_id])
    # order_detail.rbにorder_status_updateメソッドを記述
    flash[:notice] = "更新に失敗しました" if @detail.order_status_update(detail_params)
    redirect_to admin_order_path(@detail.order)
  end

  private
  def order_params
    params.require(:order).permit(:order_status)
  end
  def detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
