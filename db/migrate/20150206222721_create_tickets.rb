class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.text :numbers
      t.integer :bet_amount
      t.boolean :bonus

      t.timestamps null: false
    end
  end
end
