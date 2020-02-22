class Public::ItemsController < ApplicationController
  def top
  end

  def index
    @items = Item.all
    @genres = Genre.all
  end

  def genre_index
    @genre = Genre.find(params[:id])
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all
  end
end
