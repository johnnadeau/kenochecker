FactoryGirl.define do
  factory :user do
    email 'example@kenochecker.com'
    password 'badpassword'
    password_confirmation 'badpassword'
  end
end
