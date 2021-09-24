Track.create!([
  {name: 'levitating', artist: 'dua lipa', adam_id: '1551179407', preview_url: 'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/ab/a4/60/aba460c2-787f-7c31-ecbe-b2f50b4e4725/mzaf_12011994877481871015.plus.aac.p.m4a'},
  {name: 'butter', artist: 'BTS', adam_id: '1568022659', preview_url: 'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/65/e9/8d/65e98d2d-2dec-c3fd-5ac2-9fa1e5ef05f7/mzaf_2674274846336398167.plus.aac.p.m4a'}
])

Room.create!(name:'pop')
Room.find_by(name: 'pop').tracks << [t1,t2]