class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def total_items
    cart_items.to_a.sum { |item| item.quantity }
  end

  def total_price
    cart_items.to_a.sum { |item| item.total_price }
  end
end
