document.addEventListener("turbolinks:load", () => {
  const startBtn = document.querySelector("#startGameBtn");
  startBtn?.addEventListener("click", (e) => {
    e.preventDefault();
    displayGame();
    playlist.play();
    startBtn.style.display = "none";
  });
});

function shuffle(array) {
  let currentIndex = array.length,
    temporaryValue,
    randomIndex;
  while (0 !== currentIndex) {
    randomIndex = Math.floor(Math.random() * currentIndex);
    currentIndex -= 1;
    temporaryValue = array[currentIndex];
    array[currentIndex] = array[randomIndex];
    array[randomIndex] = temporaryValue;
  }
  return array;
}

function displayGame() {
  const question = document.querySelector("#question");
  question.style.visibility = "visible";
  question.innerText = `Guess the song:`;
  getData();
}

async function getData() {
  await fetch(`/tracks_json/${document.getElementById("room").dataset.url}`)
    .then((res) => res.json())
    .then((data) => {
      buildChoices(data);
    })
    .catch((err) => {
      console.log(err);
    });
}

function buildChoices(data) {
  let incorrectTracks = [];
  let correctTrack;
  data.forEach((track) => {
    if (track.preview_url != playlist.currentTrack.src) {
      incorrectTracks.push(track);
    } else {
      correctTrack = track;
    }
  });
  let choices = generateRandomChoices(incorrectTracks, correctTrack);
  displayChoices(choices);
  isEnded(data);
}

function generateRandomChoices(incorrectTracks, correctTrack) {
  let wrongChoices = shuffle(incorrectTracks).slice(0, 2);
  let choices = [...wrongChoices, correctTrack];
  return shuffle(choices);
}

function displayChoices(choices) {
  const choiceBtns = document.querySelectorAll(".choiceBtn");
  choiceBtns.forEach((choiceBtn, i) => {
    choiceBtn.textContent = `${choices[i].name} by ${choices[i].artist}`;
    choiceBtn.style.display = "block";
  });
}

function isEnded(data) {
  playlist.tracks.forEach((track) => {
    track.addEventListener("ended", () => buildChoices(data));
  });
}
