class Cart < ApplicationRecord
  has_many :cart_items
  has_many :items, through: :cart_items

  def apply_promotions
    PromotionEngine.new(self).apply_promotions
  end
end
