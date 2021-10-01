FactoryBot.define do
  factory :room do
    name { 'animal' }
    tracks { build_list(:track, 5) }
  end
end
