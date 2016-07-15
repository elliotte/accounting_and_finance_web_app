require 'rails_helper'

RSpec.describe Transaction, type: :model do
  
  context "assocations" do
  	it { is_expected.to belong_to(:ledger) }
  end
  
  context "attributes" do
  end

end
