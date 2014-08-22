# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email "example@email.com"
    password 123123123
    password_confirmation 123123123
  end
end
