module ReviewsHelper

  def average_stars(movie)
    if movie.average_stars.zero?
      content_tag(:strong, "No reviews")
    else
      precise_num = number_with_precision(movie.average_stars, precision: 1)
      pluralize(precise_num, "star")
    end
  end
end
