class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniaut
  attr_accessor :name

  enum is_deleted: { 有効: false, 退会済み: true }

  #複数カラムから検索
  def self.search(search)
		self.where("(last_name LIKE ? ) OR (first_name LIKE ?) OR (first_name_kana LIKE ?) OR (first_name_kana LIKE ?)", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
  end
  
  # orders_controllersのconfirmで仕様
  def user_infos
    [self.post_code, self.address, self.first_name + self.last_name]
  end

  # 退会済みのユーザーがログインできないようにする
  def active_for_authentication?
    super && self.is_deleted == "有効"
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :addresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
end
