require 'rails_helper'

describe AppImportService do

	let(:csv_file) { File.open(Rails.root + "spec/fixtures/test_trns.csv") }
	#83 rows | 1 header row
	let(:ledger) { FactoryGirl.create(:ledger) }
	let(:import_service) { AppImportService.new( ledger, csv_file ) }

	context 'initialising' do
      it 'should not initialise without a file or ledger' do
        expect { AppImportService.new }.to raise_error(StandardError)
      end

      it 'should initialise successfully with a file and ledger' do
        expect { AppImportService.new(ledger, csv_file ) }.to_not raise_error
      end
    end
    context "service methods" do
      it 'can read the a file' do
      	expect(import_service.read_file).to be_a CSV
      end
      it 'can map csv rows' do
      	output = import_service.map_csv_rows
        expect(output.count).to eq 82
        expect(output.first).to eq({:date=>"24/09/2014", :type=>"POS", :description=>"'0853 23SEP14 , MC DONALD'S , LULLY FR CH , CHF 8.90, VRATE 1.5292, FGN PUR FEE 1.00", :value=>-6.82, :balance=>3117.95, :account_name=>"'ELLIOTT ME", :account_number=>"'830608-11775465", nil=>nil})
      end
      it 'can persist data' do
      	output = import_service.map_csv_rows.first
      	expect{import_service.persist(output)}.to change(ledger.transactions, :count).by(1)
      end
      it 'can loop data and persist' do
      	expect{import_service.write_to_db}.to change(ledger.transactions, :count).by(82)
      end
    end

end 