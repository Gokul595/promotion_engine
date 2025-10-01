require "test_helper"

class CartTest < ActiveSupport::TestCase
  test "should apply percentage promotion correctly" do
    cart = carts(:one)
    item = items(:tshirt_one)
    promotion = promotions(:percentage)

    Promotion.all.where.not(id: promotion.id).update_all(status: :inactive)

    cart_item = cart.cart_items.find_by(item: item)
    cart_item.update(quantity: 2) # Add 2 quantities of the item

    cart_item.reload
    expected_discount = 4.5 # per item price is $15, 15% of 2 items is $4.5

    assert_equal expected_discount, cart_item.discount_value, "Percentage promotion not applied correctly"
  end

  test "should apply fixed amount promotion correctly" do
    cart = carts(:one)
    item = items(:hoodie_one)
    promotion = promotions(:fixed_amount)

    Promotion.all.where.not(id: promotion.id).update_all(status: :inactive)

    cart_item = cart.cart_items.find_by(item: item)
    cart_item.update(quantity: 3) # Add 3 quantities of the item

    cart_item.reload
    expected_discount = 30 # per item price is $40, $10 off on 3 items is $30

    assert_equal expected_discount, cart_item.discount_value, "Fixed amount promotion not applied correctly"
  end

  test "should apply weight threshold promotion correctly" do
    cart = carts(:one)
    item = items(:tshirt_one)
    promotion = promotions(:weight_threshold)

    Promotion.all.where.not(id: promotion.id).update_all(status: :inactive)

    cart_item = cart.cart_items.find_by(item: item)
    cart_item.update(quantity: 2) # Add 2 quantities

    cart_item.reload
    expected_discount = 6 # per item price is $15, 20% of 2 items is $6

    assert_equal expected_discount, cart_item.discount_value, "Weight threshold promotion not applied correctly"
  end

  test "should apply buy 2 get 1 promotion correctly" do
    cart = carts(:one)
    item = items(:tshirt_one)
    promotion = promotions(:buy_2_get_1_free)

    Promotion.all.where.not(id: promotion.id).update_all(status: :inactive)

    cart_item = cart.cart_items.find_by(item: item)
    cart_item.update(quantity: 6) # Add 6 quantities of the item

    cart_item.reload
    expected_discount = item.selling_price * 2 # 2 items free

    assert_equal expected_discount, cart_item.discount_value, "Buy X Get Y promotion not applied correctly"
  end

  test "should apply buy 3 get 1 50% off promotion correctly" do
    cart = carts(:one)
    item = items(:tshirt_one)
    promotion = promotions(:buy_3_get_1_50_perc_off)

    Promotion.all.where.not(id: promotion.id).update_all(status: :inactive)

    cart_item = cart.cart_items.find_by(item: item)
    cart_item.update(quantity: 4) # Add 4 quantities of the item

    cart_item.reload
    expected_discount = item.selling_price * 50 / 100 # 50% off on 1 item

    assert_equal expected_discount, cart_item.discount_value, "Buy X Get Y promotion not applied correctly"
  end

  test "should not apply inactive promotions" do
    cart = carts(:one)
    item = items(:tshirt_one)

    Promotion.update_all(status: :inactive)

    cart_item = cart.cart_items.find_by(item: item)
    cart_item.update(quantity: 2) # Add 2 quantities of the item
    cart_item.reload

    assert_equal 0, cart_item.discount_value, "Inactive promotion should not be applied"
  end

  test "should apply highest discount when multiple promotions are applicable" do
    cart = carts(:one)
    item = items(:tshirt_one)
    percentage_promotion = promotions(:percentage) # 15% off
    fixed_amount_promotion = promotions(:fixed_amount) # $10 off

    Promotion.all.where.not(id: [percentage_promotion.id, fixed_amount_promotion.id]).update_all(status: :inactive)

    cart_item = cart.cart_items.find_by(item: item)
    cart_item.update(quantity: 2) # Add 2 quantities of the item

    cart_item.reload
    expected_percentage_discount = 4.5 # 15% of $30 = $4.5
    expected_fixed_discount = 20 # $10 off on $15 each for 2 items = $20
    expected_discount = [expected_percentage_discount, expected_fixed_discount].max # Should apply the higher discount

    assert_equal expected_discount, cart_item.discount_value, "Did not apply the highest discount correctly"
  end
end
