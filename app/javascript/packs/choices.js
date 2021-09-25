document.addEventListener('turbolinks:load', () =>{
  const startBtn = document.querySelector('#startGameBtn');
  if(startBtn) {
    startBtn.addEventListener('click', () => {
      startBtn.style.display = 'none';
      startGame();
    });
  }
})

function startGame() {
  const question = document.querySelector('#questionNum');
  question.style.visibility = 'visible'
  question.innerText = `Question: ${playlist.trackNo + 1}`;
  const choiceBtns = document.querySelectorAll('.choiceBtn');
  for (const btns of choiceBtns) {
    btns.style.visibility = 'visible'
    // shuffleTracks(playlist.nameTracks, playlist.nameTracks[playlist.trackNo])
  }
  const choices = shuffleTracks([...playlist.nameTracks].slice(0,3))
  playlist.tracks.forEach((track) => {
    track.addEventListener('play', () => displayTracks(choices));
  })
}

function shuffleTracks(tracks) {
  var currentIndex = tracks.length, temporaryValue, randomIndex;
  while (0 !== currentIndex) {
    randomIndex = Math.floor(Math.random() * currentIndex);
    currentIndex -= 1;
    temporaryValue = tracks[currentIndex];
    tracks[currentIndex] = tracks[randomIndex];
    tracks[randomIndex] = temporaryValue;
  }
  return tracks;
}

function displayTracks(choices) {
  const choiceBtns = document.querySelectorAll('.choiceBtn');
  choiceBtns[0].textContent = choices[1]
  choiceBtns[1].textContent = choices[2]
  choiceBtns[2].textContent = choices[0]
}