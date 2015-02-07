class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.decimal :amount
      t.references :game, index: true
      t.references :ticket, index: true

      t.timestamps null: false
    end
    add_foreign_key :results, :games
    add_foreign_key :results, :tickets
  end
end
