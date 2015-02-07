class CreateGamesTickets < ActiveRecord::Migration
  def self.up
    create_table :games_tickets, id: false do |t|
      t.references :game
      t.references :ticket
    end
    add_index :games_tickets, [:game_id, :ticket_id]
    add_index :games_tickets, :ticket_id
  end

  def self.down
    drop_table :games_tickets
  end
end
