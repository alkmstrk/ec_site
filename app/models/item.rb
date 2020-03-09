class Item < ApplicationRecord
  enum sales_status: { 販売中: 0, 販売停止中: 1 }
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy

  attachment :image

  def self.search(search)
		self.where(['name LIKE ?', "%#{search}%"])
	end
end
