require "test_helper"

class ItemsControllerTest < ActionDispatch::IntegrationTest
  test "should list all items" do
    get items_url
    assert_response :success
    assert_equal Item.all, assigns(:items)
  end

  test "should not show item with invalid ID" do
    get item_url(30)
    assert_response :not_found
  end

  test "should show item" do
    item = items(:tshirt_one)
    get item_url(item)
    assert_response :success
    assert_equal item, assigns(:item)
  end

  test "should add item to cart" do
    item = items(:tshirt_one)
    post add_to_cart_item_url(item)
    assert_redirected_to cart_url
    follow_redirect!
    assert_response :success
    assert_includes assigns(:cart).items, item
  end

  test "should increment quantity if item already in cart" do
    item = items(:tshirt_one)
    post add_to_cart_item_url(item)
    assert_redirected_to cart_url
    follow_redirect!
    assert_response :success
    assert_includes assigns(:cart).items, item

    post add_to_cart_item_url(item)
    assert_redirected_to cart_url
    follow_redirect!
    assert_response :success
    cart_item = assigns(:cart).cart_items.find_by(item_id: item.id)
    assert_equal 2, cart_item.quantity
  end

  test "should remove item from cart" do
    item = items(:tshirt_one)
    post add_to_cart_item_url(item)

    delete remove_from_cart_item_url(item)
    assert_redirected_to cart_url
    follow_redirect!
    assert_response :success
    assert_not_includes assigns(:cart).items, item
  end
end
