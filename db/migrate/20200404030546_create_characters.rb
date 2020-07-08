class CreateCharacters < ActiveRecord::Migration[6.0]
  def change
    create_table :characters do |t|
      t.string :english
      t.string :japanese
      t.text :description
      t.integer :anime_id
      t.integer :role_id 
    end
  end
end
