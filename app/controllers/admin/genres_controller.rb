class Admin::GenresController < ApplicationController
  before_action :set_genre_all, only: [:index, :create]

  def index
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    # 三項演算子
    @genre.save ? (redirect_to admin_genres_path) : (render :index)
    # if @genre.save
    #   redirect_to admin_genres_path
    # else
    #   render :index
    # end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    @genre.update(genre_params) ? (redirect_to admin_genres_path) : (render :edit)
  end

  private
  def genre_params
    params.require(:genre).permit(:title, :is_active)
  end
end
