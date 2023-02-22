class ReviewsController < ApplicationController
  before_action :require_sign_in
  before_action :get_movie_id

  def index
    @reviews = @movie.reviews
  end

  def new
    @review = @movie.reviews.new
  end

  def create
    @review = @movie.reviews.new(movie_review_params)
    @review.user = current_user

    if @review.save
      redirect_to movie_reviews_path(@movie),
          notice: "Thanks for the review"
    else
      render :new
    end
  end

  private

  def get_movie_id
    @movie = Movie.find(params[:movie_id])
  end

  def movie_review_params
    params.require(:review).permit(:stars, :comment)
  end
end
