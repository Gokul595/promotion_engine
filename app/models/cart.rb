class Cart < ApplicationRecord
  has_many :cart_items
  has_many :items, through: :cart_items

  def apply_promotions
    PromotionEngine.new(self).apply_promotions
  end

  def total_price_before_discount
    cart_items.includes(:item).sum(&:total_price)
  end

  def total_discount
    cart_items.includes(:item).sum(&:discount_value)
  end
end
