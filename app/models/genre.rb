class Genre < ApplicationRecord
  enum is_active: { 有効: true, 無効: false }
  has_many :items, dependent: :destroy
  validates :title, presence: true
  
end
