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
    @detail.update(detail_params)
    #orderに紐づくorder_detailのmaking_statusだけを取り出す
    # @statuses = @detail.order.order_details.map{ |h| h[:making_status] }
    @statuses = @detail.order.order_details.pluck(:making_status)
    @statuses.delete("制作完了")
    if @statuses.length == 0
      @detail.order.update(order_status: "発送準備中")
    elsif @statuses.include?("製作中")
      @detail.order.update(order_status: "製作中")
    end
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
