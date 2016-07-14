require 'rails_helper'

#APP =YAML.load_file('config/application.yml')
# describe 'ledger CRUD features |', :type => :feature do
#     before do 
#       @current_user = FactoryGirl.create(:user)
#       visit root_path
#       login
#     end
#     context "creation |" do
#       it 'should add a new user ledger', js: true do
#         click_link("Start Working")
#         click_link("New Bank Hive")
#         fill_in("ledger_user_tag", with: "what-a-description")
#         click_button("Create Ledger")
#         page.should have_content "Successfully created ledger"
#       end
#     end
# end

feature "creating a new ledger" do
  before do 
    @current_user = FactoryGirl.create(:user)
    visit root_path
    first("a[href='/users/sign_in']").click()
    fill_in("user_email", with: @current_user.email)
    fill_in("user_password", with: "what-a-password")
    click_button("Log in")
    page.should have_content "Signed in successfully"
  end
  #doesn't work with JS | works with HTML
  scenario 'ledger #new', js: true do
    click_link("Start Working")
    click_link("New Bank Hive")
  end
end
