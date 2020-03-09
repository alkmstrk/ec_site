class Public::ItemsController < ApplicationController

  #indexだけでジャンル検索のワード検索の結果を表示できるようにした
  def index
    if (params[:search]) != nil && (params[:search]) != ""
      @items, @word = Item.search(params[:search]), (params[:search]) + "の検索結果"
    elsif (params[:genre_id]) != nil
      genre = Genre.find(params[:genre_id])
      @items, @word = genre.items, genre.title
    else
      @items, @word = Item.all, "全ての商品"
    end
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all
  end
end
