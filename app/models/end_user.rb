class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniaut
  
  enum is_deleted: { 有効: false, 退会済み: true }

  # 退会済みのユーザーがログインできないようにする
  def active_for_authentication?
    super && !self.is_deleted
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :addresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
end
