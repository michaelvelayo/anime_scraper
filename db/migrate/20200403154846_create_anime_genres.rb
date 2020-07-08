class CreateAnimeGenres < ActiveRecord::Migration[6.0]
  def change
  create_table :anime_genres do |t|
    t.integer :anime_id
    t.integer :genre_id
  end
  end
end
