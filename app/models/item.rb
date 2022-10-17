class Item < ApplicationRecord
  belongs_to :user
  has_one :purchase
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :pay_for_shipping
  belongs_to :prefecture
  belongs_to :days_to_ship

  with_options presence: true do
    validates :item_name
    validates :description
    validates :category_id
    validates :condition_id
    validates :pay_for_shipping_id
    validates :prefecture_id
    validates :days_to_ship_id
  end

  with_options numericality: {other_than: 0, message: "can't be blank"} do
    validates :category_id
    validates :condition_id
    validates :pay_for_shipping_id
    validates :prefecture_id
    validates :days_to_ship_id
  end

  validates :price, presence: true, numericality: {in: 300..9999999}, format: { with: /\A[0-9]+\z/ }
end
