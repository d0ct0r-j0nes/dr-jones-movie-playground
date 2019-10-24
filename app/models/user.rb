class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_movies, through: :favorites, source: :movie
  has_secure_password


  validates :name, presence: true
  validates :email, presence: true,
                    format: /\A\S+@\S+\z/,
                    uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: 10, allow_blank: true }

  def self.authenticate(email, password) #Class-level methods require 'self.(method-name)'
    user = User.find_by(email: email)
    user && user.authenticate(password) #verifies user email and password match
  end

end
