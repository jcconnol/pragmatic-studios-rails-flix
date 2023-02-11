class MoviesController < ApplicationController
  def index
    @movies = Movie.released_movies
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def update
    @movie = Movie.find(params[:id])
    @movie.update(movie_params)

    redirect_to movie_path(@movie)
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.save

    redirect_to movie_path(@movie)
  end

  def movie_params
    params[:movie].
      permit(:title, :description, :rating, :released_on, :total_gross)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_url
  end
end
