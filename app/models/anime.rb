class Anime < ActiveRecord::Base
  has_many :anime_genres
  has_many :genres, through: :anime_genres
  has_many :characters
end
