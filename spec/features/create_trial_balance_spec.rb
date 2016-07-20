require 'rails_helper'

feature "user ledgers" do
  before do
    setup_db_and_session_mock
    visit auth_dash_welcome_index_path
  end
  scenario "generate a trial balance", js: true do

    click_link("New Bank Hive")
    fill_in("ledger_user_tag", with: "yes-lad")
    click_button("Create Ledger")
    page.should have_content "Ledger successfully added"
    visit auth_dash_welcome_index_path
    
    all(".card.with-link")[0].click
    sleep(2)
    page.should have_content("GenerateTB")

    # WHY STUB NOT RETURNING @CURRENT_USER?

    # page.should have_content("Test-1")
    # page.should_not have_css(".tb-include")
  end
end

def setup_db_and_session_mock
    ApplicationController.any_instance.stub(:authenticate_user!).and_return true 
    @current_user = FactoryGirl.create(:user)
    ApplicationController.any_instance.stub(:current_user).and_return(@current_user)
end

