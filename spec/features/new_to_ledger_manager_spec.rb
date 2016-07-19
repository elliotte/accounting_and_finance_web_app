require 'rails_helper'

feature "user ledgers" do
  before do
    setup_db_and_session_mock
    visit auth_dash_welcome_index_path
  end
  scenario "create ledger and import csv transactions", js: true do
    create_user_ledger
    import_transactions
    all(".card.with-link")[0].click
    page.should have_content "Reconcilation manager"
    page.should have_content "PICKIE FUN PARK"
  end
end

def setup_db_and_session_mock
    ApplicationController.any_instance.stub(:authenticate_user!).and_return true 
    @current_user = FactoryGirl.create(:user)
    ApplicationController.any_instance.stub(:current_user).and_return(@current_user)
end

def create_user_ledger
    click_link("New Bank Hive")
    fill_in("ledger_user_tag", with: "yes-lad")
    click_button("Create Ledger")
    page.should have_content "Ledger successfully added"
end

def import_transactions
    click_link("Import CSV")
    attach_file("file", Rails.root + "spec/fixtures/test_trns.csv")
    click_button("Import CSV")
    page.should have_content "Transactions imported successfully"

end