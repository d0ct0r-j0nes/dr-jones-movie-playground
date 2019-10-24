class Genre < ApplicationRecord
    validates :name, presence: true, uniqueness: true #ensures the name is present AND unique

    has_many :characterizations, dependent: :destroy
    has_many :movies, through: :characterizations 
end
