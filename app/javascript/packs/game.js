/** Class representing the game */
class Game {
  constructor() {
    this.room = {};
    this.playlist = {};
  }
  addStartBtnListener() {
    const startBtn = document.querySelector("#startGameBtn");
    startBtn?.addEventListener("click", startGame);
  }
  startGame(e) {
    e.preventDefault();
    displayGame();
    playlist.play();
    startBtn.style.display = "none";
  }
  displayGame() {
    const question = document.querySelector("#question");
    const choiceBtns = document.querySelectorAll(".choiceBtn");
    
    question.style.visibility = "visible";
    question.innerText = `Guess the song:`;
    choiceBtn.style.display = "block";
    getData();
  }

  async getData() {
    await fetch(`/tracks_json/${document.getElementById("room").dataset.url}`)
      .then((res) => res.json())
      .then((data) => {
        buildChoices(data);
      })
      .catch((err) => {
        console.log(err);
      });
  }
  displayChoices(choices) {
    const choiceBtns = document.querySelectorAll(".choiceBtn");
    choiceBtns.forEach((choiceBtn, i) => {
      choiceBtn.textContent = `${choices[i].name} by ${choices[i].artist}`;
    });
  }

  isEnded(data) {
    playlist.tracks.forEach((track) => {
      track.addEventListener("ended", () => buildChoices(data));
    });
  }
}