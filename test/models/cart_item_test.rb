require "test_helper"

class CartItemTest < ActiveSupport::TestCase
  test "should not save cart item without cart" do
    cart_item = CartItem.new(item: items(:tshirt_one))
    assert_not cart_item.save, "Saved the cart item without a cart"
  end

  test "should not save cart item without item" do
    cart_item = CartItem.new(cart: carts(:one))
    assert_not cart_item.save, "Saved the cart item without an item"
  end

  test "should save valid cart item" do
    cart_item = CartItem.new(cart: carts(:one), item: items(:tshirt_two))
    assert cart_item.save, "Failed to save a valid cart item"
  end

  test "should not allow duplicate items in the same cart" do
    cart = carts(:one)
    item = items(:tshirt_one)

    CartItem.create(cart: cart, item: item)
    duplicate_cart_item = CartItem.new(cart: cart, item: item)

    assert_not duplicate_cart_item.save, "Saved a duplicate item in the same cart"
  end

  test "should update cart total price after adding cart item" do
    cart = carts(:one)
    initial_total = cart.total_price
    item = items(:tshirt_two)

    CartItem.create(cart: cart, item: item)
    cart.reload

    assert_equal initial_total + item.selling_price, cart.total_price, "Cart total price did not update correctly after adding item"
  end

  test "should update cart total price after removing cart item" do
    cart = carts(:one)
    item = items(:tshirt_two)
    cart_item = CartItem.create(cart: cart, item: item)
    cart.reload
    initial_total = cart.total_price

    cart_item.destroy
    cart.reload

    assert_equal initial_total - item.selling_price, cart.total_price, "Cart total price did not update correctly after removing item"
  end
end
