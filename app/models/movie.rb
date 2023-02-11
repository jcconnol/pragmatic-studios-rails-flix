class Movie < ApplicationRecord
  def self.released_movies
    where("released_on > ?", Time.now).order("released_on desc")
  end

  def flop?
    total_gross.blank? || total_gross < 500_000_000
  end
end
