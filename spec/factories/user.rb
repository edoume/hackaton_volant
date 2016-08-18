FactoryGirl.define do
  factory :user do
    email {FFaker::Internet.email}
    password 'azerty1234'
  end
end