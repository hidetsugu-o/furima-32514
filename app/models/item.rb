class Item < ApplicationRecord

  validates :title, :profile, :category_id, :status_id, :delivery_fee_id, :prefecture_id, :days_to_ship_id, :image, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }

  belongs_to :user
  has_one_attached :image
end
