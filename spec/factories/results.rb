FactoryGirl.define do
  factory :result do
    association :game
    association :ticket
  end

end
