class DropGamesTickets < ActiveRecord::Migration
  def change
    drop_table :games_tickets
  end
end
