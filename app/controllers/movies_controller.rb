class MoviesController < ApplicationController

  before_action :require_sign_in, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]

  def index
    @movies = Movie.released_movies
  end

  def show
    @movie = Movie.find(params[:id])
    @fans = @movie.fans

    if current_user
      @favorite = current_user.favorites.find_by(movie_id: @movie.id)
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      redirect_to movie_path(@movie), notice: "Movie successfully updated"
    else
      render :edit
    end
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: "Movie successfully updated"
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
