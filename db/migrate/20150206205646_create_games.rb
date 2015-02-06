class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :game_number
      t.date :game_date
      t.text :numbers
      t.integer :bonus

      t.timestamps null: false
    end
  end
end
