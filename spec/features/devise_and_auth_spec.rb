require 'rails_helper'

#APP =YAML.load_file('config/application.yml')
describe 'user landing', :type => :feature do

    context "new user" do
          before do 
            visit root_path
          end
          it 'should be on the unauth page' do
            page.should have_content "Why MircoBooks"
          end
          it 'should be allowed to sign up' do
            first("a[href='/users/sign_up']").click()
            fill_in("user_email", with: "a@a.com")
            fill_in("user_email", with: "a@a.com")
            fill_in("user_password", with: "what-a-password")
            fill_in("user_password_confirmation", with: "what-a-password")
            click_button("Sign up")
            page.should have_content "Welcome! You have signed up successfully"
          end
    end

    context "existing user" do
          before do
            @current_user = FactoryGirl.create(:user)
            visit root_path
          end
          it 'should be on the unauth page' do
            page.should have_content "Why MircoBooks"
          end
          it 'should be allowed to log in' do
            first("a[href='/users/sign_in']").click()
            fill_in("user_email", with: "user_2@profitbees.com")
            fill_in("user_password", with: "what-a-password")
            click_button("Log in")
            page.should have_content "Signed in successfully"
          end
    end

end
