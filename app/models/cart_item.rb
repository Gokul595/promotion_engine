class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :item

  validates :item_id, uniqueness: { scope: :cart_id, message: "is already in the cart" }

  after_commit :update_cart_total_price, on: [:create, :destroy]

  def update_cart_total_price
    cart.update(total_price: cart.cart_items.sum(&:total_price))
  end

  def total_price
    item.selling_price
  end
end
