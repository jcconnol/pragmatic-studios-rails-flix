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
    if  @movie.update(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @event
    else
      render :new
    end
  end

  def movie_params
    params[:movie].
      permit(
        :title,
        :description,
        :rating,
        :released_on,
        :total_gross,
        :director,
        :duration,
        :image_file_name
      )
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_url
  end
end
