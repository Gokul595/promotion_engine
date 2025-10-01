class ItemsController < ApplicationController
  before_action :set_category, only: [:index]
  before_action :set_item, only: [:show, :add_to_cart, :remove_from_cart]
  before_action :find_or_create_cart, only: [:add_to_cart, :remove_from_cart]

  def index
    @items = Item.all
    @items = @items.where(category_id: @category.id) if @category
  end

  def add_to_cart
    if @cart.items.include?(@item)
      flash[:notice] = "Item is already in the cart."
    else
      @cart.items << @item
    end

    redirect_to cart_path
  end

  def remove_from_cart
    @cart.items.destroy(@item)
    redirect_to cart_path
  end

  private

  def set_category
    @category = Category.find(params[:category_id]) if params[:category_id].present?
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def find_or_create_cart
    @cart = current_cart
    return if @cart

    @cart = Cart.create
    session[:cart_id] ||= @cart.id # Store cart ID in current session
  end
end
