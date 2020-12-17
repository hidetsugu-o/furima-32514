class ShippingAddress < ApplicationRecord
  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/ }
    validates :prefecture_id
    validates :municipality
    validates :address
    validates :phone_number, numericality: { only_integer: true }, length: { maximum: 11 }
  end

  belongs_to :buyer
end
