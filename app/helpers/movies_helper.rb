module MoviesHelper
  def day_and_time(movie)
    movie.released_on.strftime("%Y")
  end

  def total_gross(movie)

    if movie.nil?
      return "nil"
    end

    if movie.flop?
      return "Flop!"
    end

    number_to_currency(movie.total_gross, precision: 0)
  end
end
