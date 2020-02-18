class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  belongs_to :end_user
end
