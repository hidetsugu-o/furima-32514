class BuyerShippingAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :municipality,
                :address, :building, :phone_number, :buyer_id, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/ }
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :municipality
    validates :address
    validates :phone_number, numericality: { only_integer: true }, length: { maximum: 11 }
    validates :token
  end

  def save
    buyer = Buyer.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(
      postal_code: postal_code, prefecture_id: prefecture_id,
      municipality: municipality, address: address, building: building,
      phone_number: phone_number, buyer_id: buyer.id
    )
  end
end
