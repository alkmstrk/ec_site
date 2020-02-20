class Public::ItemsController < ApplicationController
  def top
  end

  def index
    @items = Item.all
    @genres = Genre.all
  end

  def show
  end
end
