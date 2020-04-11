class OrderDetail < ApplicationRecord
  enum making_status: { 着手不可: 0, 制作待ち: 1, 製作中: 2, 制作完了: 3 }
  belongs_to :order
  belongs_to :item

  def order_status_update(detail_infos)
    OrderDetail.transaction do
      self.update(detail_infos)
      #orderに紐づくorder_detailのmaking_statusの配列を作る
      # @statuses = @detail.order.order_details.map{ |h| h[:making_status] }
      statuses = self.order.order_details.pluck(:making_status)
      statuses.delete("制作完了")
      if statuses.length == 0
        self.order.update(order_status: "発送準備中")
      elsif statuses.include?("製作中")
        self.order.update(order_status: "製作中")
      end
    end
  end
  
end
