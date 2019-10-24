class Movie < ApplicationRecord
  before_validation :generate_slug
  
  has_many :reviews, dependent: :destroy #points to reviews, destroys reviews if parent is destroyed
  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user #through association giving a movie x fans by way of user favorites
  has_many :characterizations, dependent: :destroy
  has_many :genres, through: :characterizations #through association, no source needed as it pulls from an admin db



  validates :title, presence: true, uniqueness: true
  validates :duration, :released_on, presence: true
  validates :description, length: {minimum: 25}
  
  validates :total_gross, numericality: {greater_than_or_equal_to: 0}
  
  validates :image_file_name, allow_blank: true, format: {
    with: /\w+\.(gif|jpg|png)\z/i,
    message: "must reference a GIF, JPG, or PNG image"
  }
  
  validates :slug, uniqueness: true
  
  RATINGS = %w(G PG PG-13 R NC-17)
  validates :rating, inclusion: { in: RATINGS }

  scope :released, -> {where("released_on <= ?", Time.now).order("released_on desc")} #lambda -> {is a ruby thing}
  scope :hits, -> { released.where('total_gross >= 300000000').order(total_gross: :desc)}
  scope :flops, -> { released.where('total_gross < 50000000').order(total_gross: :asc)}
  scope :upcoming, -> { where("released_on > ?", Time.now).order(released_on: :asc)}
  scope :rated, ->(rating) { released.where(rating: rating)} #passes in a rating for scope eg (Movie.rated("PG"))
  scope :recent, ->(max=5) {released.limit(max)} #returns maximum 5 movies


  # def self.released
  #   where("released_on <= ?", Time.now).order("released_on desc")
  # end

  # def self.hits
    
  # end

  # def self.flops
    
  # end

  def generate_slug
    self.slug ||=title.parameterize if title
  end


  def self.recently_added
    order('created_at desc').limit(3)
  end

  def flop?
    total_gross.blank? || total_gross < 50000000
  end

  def average_stars
    reviews.average(:stars)
  end

  def to_param
    slug
    #"#{id}-#{title.parameterize}" #converts movie title to friendly url, parameterize takes care of spaces in movie title
  end


end
