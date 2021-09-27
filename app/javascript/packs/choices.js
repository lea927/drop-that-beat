document.addEventListener("turbolinks:load", () => {
  const startBtn = document.querySelector("#startGameBtn");
  if (startBtn) {
    startBtn.addEventListener("click", () => {
      startBtn.style.display = "none";
      startGame();
    });
  }
});

function shuffleTracks(tracks) {
  let currentIndex = tracks.length,
    temporaryValue,
    randomIndex;
  while (0 !== currentIndex) {
    randomIndex = Math.floor(Math.random() * currentIndex);
    currentIndex -= 1;
    temporaryValue = tracks[currentIndex];
    tracks[currentIndex] = tracks[randomIndex];
    tracks[randomIndex] = temporaryValue;
  }
  return tracks;
}

function startGame() {
  const question = document.querySelector("#question");
  question.style.visibility = "visible";
  question.innerText = `Guess the song:`;
  const choiceBtns = document.querySelectorAll(".choiceBtn");
  for (const btns of choiceBtns) {
    btns.style.display = "block";
  }
  isPlaying();
}

function isPlaying() {
  playlist.tracks.forEach((track) => {
    track.addEventListener("play", (e) => {
      e.preventDefault();
      getData(e);
    });
  });
}

async function getData(e) {
  e.preventDefault();
  await fetch(`/tracks_json/${document.getElementById("room").dataset.url}`)
    .then((res) => res.json())
    .then((data) => {
      setData(data);
    })
    .catch((err) => {
      console.log(err);
    });
}

function setData(data) {
  let incorrectTracks = [];
  let correctTrack;
  data.forEach((track) => {
    if (track.preview_url != playlist.currentTrack.src) {
      incorrectTracks.push(track);
    } else {
      correctTrack = track;
    }
  });
  let wrongChoices = shuffleTracks(incorrectTracks).slice(0, 2);
  displayChoices(wrongChoices, correctTrack);
}

function displayChoices(wrongChoices, correctTrack) {
  let choices = [...wrongChoices, correctTrack];
  let shuffledChoices = shuffleTracks(choices);
  const choiceBtns = document.querySelectorAll(".choiceBtn");
  choiceBtns[0].textContent = `${shuffledChoices[1].name} by ${shuffledChoices[1].artist}`;
  choiceBtns[1].textContent = `${shuffledChoices[2].name} by ${shuffledChoices[2].artist}`;
  choiceBtns[2].textContent = `${shuffledChoices[0].name} by ${shuffledChoices[0].artist}`;
  let data = incorrectTracks;
  incorrectTracks.push(correctTrack);
  isEnded(data);
}

function isEnded(data){
  track.addEventListener("ended", (e) => {
    e.preventDefault();
      setData(data);
  })
}