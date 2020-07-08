class Genre < ActiveRecord::Base
  has_many :anime_genres
  has_many :animes, through: :anime_genres
end
