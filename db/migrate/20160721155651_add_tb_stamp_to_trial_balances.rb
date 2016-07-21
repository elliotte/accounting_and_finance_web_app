class AddTbStampToTrialBalances < ActiveRecord::Migration
  def change
    add_column :trial_balances, :tb_uuid, :uuid
  end
end
