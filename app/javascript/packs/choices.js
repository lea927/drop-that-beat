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
  const choiceBtns = document.querySelectorAll(".choiceBtn");
  for (const btns of choiceBtns) {
    btns.style.display = "block";
  }
  isPlaying();
}

function isPlaying() {
  document.querySelector("#question").innerText = `Guess the song:`;
  playlist.tracks.forEach((track) => {
    track.addEventListener("play", (e) => {
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
  let correctTrack = "";
  data.forEach((track) => {
    if (track.preview_url != playlist.currentTrack.src) {
      incorrectTracks.push(track.name);
    } else {
      correctTrack = track.name;
    }
  });
    displayChoices(incorrectTracks, correctTrack, 3);
}

function displayChoices(incorrectTracks, correctTrack, numOfChoices) {
  let wrongChoices = shuffleTracks(incorrectTracks).slice(0, numOfChoices);
  let choices = [...wrongChoices, correctTrack];
  let shuffledChoices = shuffleTracks(choices);
  const choiceBtns = document.querySelectorAll(".choiceBtn");
  choiceBtns[0].textContent = shuffledChoices[1];
  choiceBtns[1].textContent = shuffledChoices[2];
  choiceBtns[2].textContent = shuffledChoices[0];
  isPlaying();
}
