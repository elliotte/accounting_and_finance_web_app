class DropAndReLoadLedgerTable < ActiveRecord::Migration
  def change
  	drop_table :ledgers
  end
end
