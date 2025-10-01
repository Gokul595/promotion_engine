class AddDiscountToCartItem < ActiveRecord::Migration[7.2]
  def change
    add_reference :cart_items, :promotion, foreign_key: true
    add_column :cart_items, :discount_value, :float, default: 0.0
  end
end
