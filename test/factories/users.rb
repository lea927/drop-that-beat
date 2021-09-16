FactoryBot.define do
  factory :user do
    username { 'johndoe' }
    email { 'johndoe@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    trait :rooms do
      rooms { [association(:rooms)] }
    end
  end
end
