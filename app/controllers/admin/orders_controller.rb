class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.all
    @total_amount = 0
  end

  def show
    shipping_cost
    tax
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    if @order.order_status == "入金確認"
      @order.order_details.each do |detail|
        detail.update(making_status: "制作待ち")
      end
    end
  end

  def detail_update
    @detail = OrderDetail.find(params[:order_detail_id])
    @detail.update(detail_params)
    #orderに紐づくorder_detailのmaking_statusだけを取り出す
    @statuses = @detail.order.order_details.map{ |h| h[:making_status] }
    @statuses.delete("制作完了")
    if @statuses.length == 0
      @detail.order.update(order_status: "発送準備中")
    elsif @statuses.include?("製作中")
      @detail.order.order_status == "製作中"
    end
  end

  private
  def order_params
    params.require(:order).permit(:order_status)
  end
  def detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
