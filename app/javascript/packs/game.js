/**
 * @fileoverview This document defines the logic of the game
 * @requires /api/index.js:MusicApiClient - To fetch the data from db
 * @requires /model/room.js:Room - Room data which is the basis for the game
 * @requires /playlist.js:Playlist - Track Audio elements to be played
 * @requires /loader.js:Loader
 */

import MusicApiClient from './api';
import Room from './model/room';
import Playlist from './playlist';
import * as LOADER from './loader';
/** Class representing the game */
class Game {
	constructor() {
		this.room;
		this.playlist;
		this.initialize();
	}
	async initialize() {
		await this.setGameRoomDetails(); // Need to get the game data before adding the event listeners
		this.addEventListeners();
	}
	async setGameRoomDetails() {
		await this.fetchRoomDetails();
		this.room = new Room(this.room);
		this.playlist = new Playlist(this.room.tracksUrl);
	}
	async fetchRoomDetails() {
		this.room = await MusicApiClient.room();
	}
	addEventListeners() {
		this.addStartBtnListener();
		this.addTracksListener();
		document.addEventListener('turbolinks:load', () => this.endGame()); // To stop music when user exits page
	}
	addStartBtnListener() {
		const startBtn = document.querySelector('#startGameBtn');
		startBtn?.addEventListener('click', () => {
			startBtn.style.display = 'none'; // Hide start button
			this.startGame();
		});
	}
	addTracksListener() {
		this.addTextToChoiceBtns = this.addTextToChoiceBtns.bind(this); // bind addTextToChoiceBtns function to Game instance
		this.playlist.tracks.forEach((track) => {
			track.addEventListener('play', () => {
				this.addTextToChoiceBtns();
				LOADER.loader();
			});
		});
		track.addEventListener('ended', () => {
			this.resetChoiceBtns();
		});
	}
	addChoiceBtnListener() {
		this.saveAnswer = this.saveAnswer.bind(this);
		this.getCurrentTrackData = this.getCurrentTrackData.bind(this);
		$('input[data-action="submit"]').on('click', (evt) => {
			this.saveAnswer({
				index: evt.target.value, // index of button clicked
				currentTrackData: this.getCurrentTrackData(),
			});
			this.disableBtns();
		});
	}
	startGame() {
		this.displayGame();
		LOADER.showLoader();
		this.playlist.play();
	}
	endGame() {
		this.playlist.end();
		this.hideGame();
	}
	displayGame() {
		const question = document.querySelector('#question');
		const choiceBtns = document.querySelectorAll('.choiceBtn');

		question.style.visibility = 'visible';
		// Display choice buttons
		choiceBtns.forEach((choiceBtn) => {
			choiceBtn.style.display = 'block';
		});
	}
	hideGame() {
		$('#choices').addClass('d-none');
	}
	/**
	 * Get current track details
	 * @returns {Question} current question
	 */
	getCurrentTrackData() {
		let trackNo = this.playlist.trackNo; // Currently playing track number
		return this.room.questions[trackNo];
	}
	/** Save answer to database */
	saveAnswer({ index, currentTrackData }) {
		if (index == undefined || currentTrackData == undefined) throw new SyntaxError('Object does not have index or currentTrackData property');
		currentTrackData.addAnswer(index).postAnswer(this.room.id);
	}
	/** Disable buttons to prevent changing answer */
	disableBtns() {
		$('input[data-action="submit"]').prop('disabled', true);
	}
	/** Reset choice buttons to be able to select buttons again */
	resetChoiceBtns() {
		$('input[data-action="submit"]').prop('disabled', false);
		$('input[data-action="submit"]').prop('checked', false);
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
		$('.choiceBtn').each(function (index) {
			this.textContent = choices[index];
		});
	}
}

window.Game = Game; // Add Game as global variable
