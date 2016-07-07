# Read about factories at https://github.com/thoughtbot/factory_girl
FactoryGirl.define do
  factory :user do
    sequence(:email) { |i| "user_#{i}@profitbees.com" }
    password "what-a-password"
  end
end
