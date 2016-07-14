require 'rails_helper'

feature "user ledgers" do
  before do
    setup_db_and_session_mock
    visit auth_dash_welcome_index_path
  end
  scenario 'create #new', js: true do
    click_link("New Bank Hive")
    fill_in("ledger_user_tag", with: "yes-lad")
    click_button("Create Ledger")
    page.should have_content "Ledger successfully added"
    expect(@current_user.ledgers.count).to eq 1
  end
end

def setup_db_and_session_mock
    ApplicationController.any_instance.stub(:authenticate_user!).and_return true 
    @current_user = FactoryGirl.create(:user)
    ApplicationController.any_instance.stub(:current_user).and_return(@current_user)
end
