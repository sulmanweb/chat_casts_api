FactoryBot.define do
  factory :verification do
    association :user
    v_type 'confirm'
    status 'pending'
  end
end
