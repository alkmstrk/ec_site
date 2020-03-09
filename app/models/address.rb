class Address < ApplicationRecord
  belongs_to :end_user

  def p_c_a_n
    "〒" + self.post_code + "　" + self.address + "　"  + self.name
  end
end
