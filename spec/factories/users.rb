FactoryGirl.define do
  factory :user do
    sequence(:id) { |n| n }
    email "user@user.com"
    name "user"
    password "123456"
    role "user"
  end
end
