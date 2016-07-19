class AddReconciledToTransaction < ActiveRecord::Migration
  def change
  	 add_column :transactions, :reconciled, :boolean, :default => false
  end
end
