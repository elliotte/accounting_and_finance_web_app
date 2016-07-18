class Ledger < ActiveRecord::Base

	belongs_to :user
	has_many :transactions, dependent: :destroy

	accepts_nested_attributes_for :transactions

end

