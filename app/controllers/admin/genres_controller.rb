class Admin::GenresController < ApplicationController
  before_action :set_genre_all, only: [:index, :create]

  def index
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path
    else
      render :index
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genres_path
    else
      render :edit
    end
  end

  private
  def genre_params
    params.require(:genre).permit(:title, :is_active)
  end
end
