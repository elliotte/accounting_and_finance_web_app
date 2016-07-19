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
  scenario "create ledger and edit mapping of transaction", js: true do
    create_user_ledger
    @ledger = @current_user.ledgers.create(user_tag: "testingTag")
    click_link("Import CSV")
    attach_file("file", Rails.root + "spec/fixtures/1_test_trn.csv")
    click_button("Import CSV")
    page.should have_content "Transactions imported successfully"
    all(".card.with-link")[0].click
    expect(within(".grid-items-lines"){all("a")}.count).to eql(2)
    all(".grid-item")[0].click
    sleep(1)
    expect(page).to have_css("select#transaction_tb_mapping")
    expect(page).to have_select("transaction_tb_mapping")
    find('#transaction_tb_mapping').find(:xpath, 'option[2]').select_option
    click_button("Save Transaction")
    page.evaluate_script 'window.location.reload()'
    page.should_not have_content "Turnover"
    # last updated moves to end
    all(".grid-item")[1].click
    page.should have_content "Turnover"
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