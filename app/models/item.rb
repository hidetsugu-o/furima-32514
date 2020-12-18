class Item < ApplicationRecord
  validates :title, :profile, :category_id, :status_id, :delivery_fee_id, :prefecture_id, :days_to_ship_id, :image, presence: true
  validates :price, presence: true, numericality: {
    only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999
  }

  belongs_to :user
  has_one :buyer
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :days_to_ship

  validates :category_id, :status_id, :delivery_fee_id, :prefecture_id, :days_to_ship_id, numericality: {
    other_than: 1, message: 'を選択してください'
  }
end
