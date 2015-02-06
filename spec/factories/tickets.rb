FactoryGirl.define do
  factory :ticket do
    numbers [1, 2, 3, 4, 5]
    bet_amount 2
    bonus false
  end
end
