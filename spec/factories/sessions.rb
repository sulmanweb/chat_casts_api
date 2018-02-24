FactoryBot.define do
  factory :session do
    association :user
    active true
  end
end
