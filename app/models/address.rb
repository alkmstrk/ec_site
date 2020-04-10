class Address < ApplicationRecord
  belongs_to :end_user

  def total_addresses
    "〒" + self.post_code + "　" + self.address + "　"  + self.name
  end
end
