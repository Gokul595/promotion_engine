require "test_helper"

class ItemsControllerTest < ActionDispatch::IntegrationTest
  test "should list all items" do
    get items_url
    assert_response :success
    assert_equal Item.all, assigns(:items)
  end

  test "should now show item with invalid ID" do
    get item_url(30)
    assert_response :not_found
  end

  test "should show item" do
    item = items(:tshirt_one)
    get item_url(item)
    assert_response :success
    assert_equal item, assigns(:item)
  end
end
