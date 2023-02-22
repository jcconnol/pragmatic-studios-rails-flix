class Movie < ApplicationRecord
  RATINGS = %w(G PG PG-13 R NC-17)

  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :fans, through: :favorites, source: :user

  validates :title, :released_on, :duration, presence: true
  validates :description, length: { minimum: 25 }
  validates :total_gross, numericality: { greater_than: 0 }
  validates :image_file_name, format: {
    with: /\w+\.(jpg|png)\z/i,
    message: "must be a JPG or PNG image"
  }

  validates :rating, :inclusion=> { :in => RATINGS }

  def self.released_movies
    where("released_on > ?", Time.now).order("released_on desc")
  end

  def average_stars
    reviews.average(:stars) || 0.0
  end

  def flop?
    total_gross.blank? || total_gross < 500_000_000
  end
end
