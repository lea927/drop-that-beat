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
    this.addEventListeners();
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
  /**
   * Get the choice names based on the current question
   * @returns {Array<string>} choiceNames
   */
  getChoiceNames() {
    let currentTrackNo = this.playlist.trackNo; // To determine the current track
    let currentQuestion = this.room.questions[currentTrackNo];
    
  }
  addTextToChoiceBtns() {
    let choices = this.getChoiceNames();
    $(".choiceBtn").each(function(index) {(this.textContent) = choices[index]});
  }
}
