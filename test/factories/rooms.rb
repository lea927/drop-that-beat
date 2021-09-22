FactoryBot.define do
  factory :room do
    name { 'animal' }
    trait :tracks do
      tracks { [association(:track)] }
    end
  end
end
