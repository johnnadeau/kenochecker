FactoryGirl.define do
  factory :result do
    amount "9.99"
    association :game
    association :ticket
  end

end
