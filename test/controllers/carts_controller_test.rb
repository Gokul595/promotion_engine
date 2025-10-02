require "test_helper"

class CartsControllerTest < ActionController::TestCase
  test "should show cart" do
    cart = carts(:one)
    @controller.session[:cart_id] = cart.id

    get(:show)
    assert_response :success

    assert_equal cart, assigns(:cart)
    assert_equal cart.cart_items, assigns(:cart_items)
    assert_equal cart.items, assigns(:cart).items
  end

  test "should reset cart session value with invalid ID" do
    cart = carts(:one)
    @controller.session[:cart_id] = 30

    get(:show)

    assert_response :success
    assert_nil @controller.session[:cart_id]
  end
end
