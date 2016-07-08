require 'rails_helper'

RSpec.describe User, type: :model do
  
  context "assocations" do
  	it { is_expected.to have_many(:ledgers) }
    #it { is_expected.to have_many(:transactions) }
  end

  context "attributes" do 
  	before do 
  		@user = FactoryGirl.create(:user, email: "test@1.com")	
  	end
  	it "should have a uuid as ID" do	
  	  a_uuid_eg = SecureRandom.uuid
      expect(@user.id.length).to eq(a_uuid_eg.length)
  	end
  end

end
