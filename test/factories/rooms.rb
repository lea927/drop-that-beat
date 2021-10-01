FactoryBot.define do
  factory :room do
    name { 'animal' }
    tracks { build_list(:track, 5) }
    trait :stub_tracks do
      tracks { build_stubbed_list(:track, 5) }
    end
    trait :users do
      users { [association(:user)] }
    end
  end
end
