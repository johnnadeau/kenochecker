class RemoveAmountFromResults < ActiveRecord::Migration
  def change
    remove_column :results, :amount, :decimal
  end
end
