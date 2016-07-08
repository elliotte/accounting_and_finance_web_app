class ReloadLedgerTable < ActiveRecord::Migration
  def change
  	create_table :ledgers, id: :uuid do |t|
      t.references :user, type: :uuid, null: false, index: true
      t.string :title
	  t.datetime :created_at
	  t.datetime :updated_at
	  t.string   :type
	  t.string   :user_tag
	  t.decimal  :opening_balance
      t.timestamps
    end
  end
end
