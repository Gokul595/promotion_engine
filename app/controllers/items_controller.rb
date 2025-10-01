class ItemsController < ApplicationController
  before_action :set_category, only: [:index]

  def index
    @items = Item.all
    @items = @items.where(category_id: @category.id) if @category
  end

  def show
    @item = Item.find(params[:id])
  end

  private

  def set_category
    @category = Category.find(params[:category_id]) if params[:category_id].present?
  end
end
