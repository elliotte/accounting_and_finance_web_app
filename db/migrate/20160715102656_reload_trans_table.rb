class ReloadTransTable < ActiveRecord::Migration
  def change
  	create_table :transaction, id: :uuid do |t|
      t.references :ledger, type: :uuid, index: true
  	  t.datetime :created_at
  	  t.datetime :updated_at
      t.decimal :amount
      t.decimal :tax, default: 0.0
      t.datetime :acc_date
      t.string :bank_description
      t.string :type
      t.string :tb_mapping
    end
  end
end
