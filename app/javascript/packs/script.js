window.addEventListener('load', (event) => {
  setTimeout(changeAudioSource(), 3000);
});

function changeAudioSource() {
  let audio = document.getElementById('audio');
  let source = document.getElementById('audioSource');

  source.src = 'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/65/e9/8d/65e98d2d-2dec-c3fd-5ac2-9fa1e5ef05f7/mzaf_2674274846336398167.plus.aac.p.m4a';

  audio.load(); //call this to just preload the audio without playing
  audio.play(); //call this to play the song right away
}
