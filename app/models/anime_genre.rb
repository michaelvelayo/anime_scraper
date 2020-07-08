class AnimeGenre < ActiveRecord::Base
  belongs_to :anime
  belongs_to :genre
end
