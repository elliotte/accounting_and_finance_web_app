require 'rails_helper'

RSpec.describe Ledger, type: :model do
  
  context "assocations" do
  	it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:transactions) }
  end
  
  context "attributes" do
  	
  	before do
  	  @user = FactoryGirl.create(:user, email: "test@1.com")	
  	  @ledger = FactoryGirl.create(:ledger)
  	end
  	it "should have a uuid as ID" do	
  	  a_uuid_eg = SecureRandom.uuid
      expect(@ledger.id.length).to eq(a_uuid_eg.length)
  	end
  	it 'should have a uuid reference index' do
    	@user.ledgers << @ledger
    	expect(@ledger.user_id).to eq(@user.id)
    end
  	it 'should have relevant model attributes' do
  	  expect(@ledger.attributes.keys).to eq(["id", "user_id", "title", "created_at", "updated_at", "type", "user_tag", "opening_balance"])
  	end

  end

end
