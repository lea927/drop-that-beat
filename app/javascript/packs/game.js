import MusicApiClient from './api'
import Room from './model/room'
import Playlist from './playlist'

/** Class representing the game */
class Game {
  constructor() {
    this.room = {};
    this.playlist = {};
    this.initialize();
  }
  async initialize() {
    await this.setGameRoomDetails(); // Need to get the game data before adding the event listeners
  }
  addEventListeners() {
    this.addStartBtnListener();
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
    // Display choice buttons
    choiceBtns.forEach((choiceBtn) => {choiceBtn.style.display = "block"});
    getData();
  }
  async setGameRoomDetails() {
    await this.fetchRoomDetails();
    this.room = new Room(this.room);
    this.playlist = new Playlist(this.room.tracksUrl);
  }
  async fetchRoomDetails() {
    this.room = await MusicApiClient.room();
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