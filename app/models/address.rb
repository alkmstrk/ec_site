class Address < ApplicationRecord
  belongs_to :end_user

  # orders/new.html.erbで使用。コレクションセレクトに住所全部を表示させるため
  def total_addresses
    "〒" + self.post_code + "　" + self.address + "　"  + self.name
  end

  # public/orders#confirmで使用
  def address_infos
    [self.post_code, self.address, self.name]
  end
end
