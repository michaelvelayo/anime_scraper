class CreateAnimes < ActiveRecord::Migration[6.0]
  def change
    create_table :animes do |t|
      t.string :english
      t.string :synonyms
      t.string :japanese
      t.text :summary
      t.integer :episodes
      t.integer :type_id
      t.date :started_at
      t.date :ended_at
    end
  end
end
