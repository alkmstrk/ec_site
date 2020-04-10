class Order < ApplicationRecord
  enum payment_method: { クレジットカード: 0, 銀行振込: 1 }
  enum order_status: { 入金待ち: 0, 入金確認: 1, 製作中: 2, 発送準備中: 3, 発送済み: 4  }
  has_many :order_details, dependent: :destroy
  belongs_to :end_user

  # 購入機能
  # 処理が一つでも失敗したら、全て取り消せす。全て完了してはじめてコミットする
  def order_complete(user)
    Order.transaction do
      self.save!
      user.cart_items.each do |item|
        OrderDetail.create!(order_id: self.id, item_id: item.item.id, price: item.item.price, amount: item.amount)
        item.destroy!
      end
    end
  end

end
