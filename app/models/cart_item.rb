class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :item
  belongs_to :promotion

  validates :item_id, uniqueness: { scope: :cart_id, message: "is already in the cart" }

  after_commit :apply_promotions, on: [:create, :destroy]

  def apply_promotions
    cart.apply_promotions # Reapply promotions to ensure discounts are up-to-date
  end

  def total_price
    item.selling_price * quantity
  end

  def total_price_after_discount
    item.selling_price * quantity - (discount_value || 0)
  end
end
