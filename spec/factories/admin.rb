FactoryGirl.define do
  factory :admin do
    email 'exmaple@admin.com'
    password 123_123_123
    password_confirmation 123_123_123
  end
end
