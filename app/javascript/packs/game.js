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
    this.addTracksListener();
  }
  addStartBtnListener() {
    const startBtn = document.querySelector("#startGameBtn");
    startBtn?.addEventListener("click", () => {
      startBtn.style.display = "none"; // Hide start button
      this.startGame();
    })
  }
  addTracksListener() {
    this.addTextToChoiceBtns = this.addTextToChoiceBtns.bind(this); // bind addTextToChoiceBtns function to Game instance
    this.playlist.tracks.forEach((track) => {
      track.addEventListener('play', () => {
        this.addTextToChoiceBtns();
      });
    });
  }
  startGame() {
    this.displayGame();
    this.playlist.play();
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
    let choiceNames = currentQuestion.choices.map((choice) => choice.displayName);
    return choiceNames;
  }
  addTextToChoiceBtns() {
    let choices = this.getChoiceNames();
    $(".choiceBtn").each(function(index) {(this.textContent) = choices[index]});
  }
}
