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

  test "should not show cart with invalid ID" do
    cart = carts(:one)
    @controller.session[:cart_id] = 30

    assert_raises(ActiveRecord::RecordNotFound) do
      get(:show)
    end
  end
end
