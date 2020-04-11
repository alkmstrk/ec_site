class Public::ItemsController < ApplicationController
  #アプリケーションコントローラーに記述
  before_action :set_genre_all, only: [:index, :show]

  #indexだけでジャンル検索、ワード検索の結果を表示できるようにした
  def index
    # adminでも使うのでapplication_controllerに記述
    item_search
  end

  def show
    set_item
    @cart_item = CartItem.new
  end

end
