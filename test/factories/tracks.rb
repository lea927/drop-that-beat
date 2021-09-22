FactoryBot.define do
  factory :track do
    name { 'Levitating' }
    artist { 'Dua Lipa' }
    adam_id { '1551179407' }
    preview_url { 'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/ab/a4/60/aba460c2-787f-7c31-ecbe-b2f50b4e4725/mzaf_12011994877481871015.plus.aac.p.m4a' }
    trait :rooms do
      tracks { [association(:room)] }
    end
  end
end
