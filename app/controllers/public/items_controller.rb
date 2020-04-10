class Public::ItemsController < ApplicationController
  #アプリケーションコントローラーに記述
  before_action :set_genre_all, only: [:index, :show]
  before_action :set_item, only: [:show]

  #indexだけでジャンル検索のワード検索の結果を表示できるようにした
  def index
    # nilの場合はfalse
    if (params[:search]) && (params[:search]) != ""
      @items, @word = Item.search(params[:search]), (params[:search]) + "の検索結果"
    elsif (params[:genre_id]) 
      genre = Genre.find(params[:genre_id])
      @items, @word = genre.items, genre.title
    else
      @items, @word = Item.all, "全ての商品"
    end
  end

  def show
    @cart_item = CartItem.new
  end
end
