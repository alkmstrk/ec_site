class Admin::ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update]
  before_action :set_genre_all, only: [:index]
  
  def index
    if (params[:search]) && (params[:search]) != ""
      @items, @word = Item.search(params[:search]), (params[:search]) + "の検索結果"
    else
      @items, @word = Item.all, "全ての商品"
    end
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item)
    else
      render :new
    end
  end

  def update 
    if @item.update(item_params)
      redirect_to admin_item_path(@item)
    else
      render :edit
    end
  end

  private
  def item_params
    params.require(:item).permit(:genre_id, :name, :image, :introduction, :price, :sales_status)
  end

end
