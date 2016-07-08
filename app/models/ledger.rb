class Ledger < ActiveRecord::Base

	belongs_to :user
	#has_many :transactions, foreign_key: :ledger_id, dependent: :destroy
end
