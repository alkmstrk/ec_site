class Admin::ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update]

  def index
    set_genre_all
    item_search
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.save ? (redirect_to admin_item_path(@item)) : (render :new)
  end

  def update 
    @item.update(item_params) ? (redirect_to admin_item_path(@item)) : (render :edit)
  end

  private
  def item_params
    params.require(:item).permit(:genre_id, :name, :image, :introduction, :price, :sales_status)
  end

end
