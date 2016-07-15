class Ledger < ActiveRecord::Base

	belongs_to :user
	has_many :transactions, dependent: :destroy

end
