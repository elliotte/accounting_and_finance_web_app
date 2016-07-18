require 'csv'

CSV::Converters[:blank_to_nil] = lambda do |field|
  field && field.empty? ? nil : field
end

class AppImportService

	def initialize ledger, csv_file
		@ledger = ledger
		@csv_file = csv_file
		@collection = @ledger.transactions
	end

	def read_file
		csv = CSV.new(@csv_file, headers:  true, header_converters: :symbol, converters: [:all, :blank_to_nil])
	end

	def map_csv_rows
		read_file.to_a.map { |row| row.to_hash }
	end

	def loop_data 
		map_csv_rows.each do |transaction|
			persist(transaction)
		end
	end

	def persist data
		type = ""
	    data[:value] < 0 ? type = "Credit" : type = "Debit"
		#change to build for booking control
		@collection.create(

			acc_date: data[:date].to_datetime,
			bank_description: data[:description],
			type: type,
			amount: data[:value].to_f.abs

	    )	
	end

	def write_to_db
		loop_data
	end

end