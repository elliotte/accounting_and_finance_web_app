class CreateTrialBalances < ActiveRecord::Migration
  def change
    create_table :trial_balances do |t|
      t.string :guid_ledger
      t.string :guid_user
      t.timestamps
    end
  end
end
