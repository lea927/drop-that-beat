FactoryBot.define do
  factory :room do
    name { 'animal' }
    trait :tracks do
      tracks { [association(:tracks)] }
    end
  end
end
