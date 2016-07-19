class DropTableDoubleTransaction < ActiveRecord::Migration
  def change
  	drop_table :transaction
  end
end
