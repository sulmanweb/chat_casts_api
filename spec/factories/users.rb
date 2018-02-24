FactoryBot.define do
  factory :user do
    name "Sulman Baig"
    sequence(:username) {|n| "sbaig#{n}"}
    sequence(:email) {|n| "sbaig#{n}@gmail.com"}
    password "abcd@1234"
  end
end
