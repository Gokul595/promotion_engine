class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :item
  belongs_to :promotion, optional: true

  validates :item_id, uniqueness: { scope: :cart_id, message: "is already in the cart" }

  after_commit :apply_promotions, if: :should_apply_promotions?

  def total_price
    item.selling_price * quantity
  end

  def total_price_after_discount
    total_price - (discount_value || 0)
  end

  private

  # Recalculate promotions when cart changes
  def apply_promotions
    cart.apply_promotions
  end

  # Promotion should be reapplied on create, destroy, or quantity change
  def should_apply_promotions?
    saved_change_to_quantity? || created_at_previously_changed? || destroyed?
  end
end
