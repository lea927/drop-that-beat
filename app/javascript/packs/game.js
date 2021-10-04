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
const GAME = {
	room: {},
	playlist: {},
	async initialize() {
		await GAME.setGameRoomDetails(); // Need to get the game data before adding the event listeners
		GAME.addEventListeners();
	},
	async setGameRoomDetails() {
		await GAME.fetchRoomDetails();
		GAME.room = new Room(GAME.room);
		GAME.playlist = new Playlist(GAME.room.tracksUrl);
	},
	async fetchRoomDetails() {
		GAME.room = await MusicApiClient.room();
	},
	addEventListeners() {
		GAME.addStartBtnListener();
		GAME.addTracksListener();
		GAME.addChoiceBtnListener();
		document.addEventListener('turbolinks:render', () => {
			Turbolinks.clearCache();
		});
		document.addEventListener('turbolinks:before-cache', () => {
			// Turbolinks won't cache the playing playlist
			GAME.endGame();
			GAME.room = {};
			GAME.playlist = {};
		});
	},
	addStartBtnListener() {
		const startBtn = document.querySelector('#startGameBtn');
		startBtn?.addEventListener('click', () => {
			startBtn.style.display = 'none'; // Hide start button
			GAME.startGame();
		});
	},
	addTracksListener() {
		GAME.playlist.tracks.forEach((track) => {
			track.addEventListener('play', () => {
				GAME.addTextToChoiceBtns();
				LOADER.loader();
			});
			track.addEventListener('ended', () => {
				GAME.resetChoiceBtns();
			});
		});
		GAME.playlist.lastTrack.addEventListener('ended', () => {
			GAME.hideGame();
			$('#endGame').removeClass('d-none');
		});
	},
	addChoiceBtnListener() {
		$('input[data-action="submit"]').on('click', (evt) => {
			GAME.saveAnswer({
				index: evt.target.value, // index of button clicked
				currentTrackData: GAME.getCurrentTrackData(),
			});
			GAME.disableBtns();
		});
	},
	startGame() {
		GAME.displayGame();
		LOADER.showLoader();
		GAME.playlist.play();
	},
	endGame() {
		GAME.playlist.end();
		GAME.hideGame();
	},
	displayGame() {
		$('#question').prop('style', 'visibility: visible');
		$('#choices').removeClass('d-none');
	},
	hideGame() {
		$('#choices').addClass('d-none');
		$('#endGame').addClass('d-none');
		$('#startGameBtn').attr('style', 'display:block');
		LOADER.hideLoader();
	},
	/**
	 * Get current track details
	 * @returns {Question} current question
	 */
	getCurrentTrackData() {
		let trackNo = GAME.playlist.trackNo; // Currently playing track number
		return GAME.room.questions[trackNo];
	},
	/** Save answer to database */
	saveAnswer({ index, currentTrackData }) {
		if (index == undefined || currentTrackData == undefined) throw new SyntaxError('Object does not have index or currentTrackData property');
		currentTrackData.addAnswer(index).postAnswer(GAME.room.id);
	},
	/** Disable buttons to prevent changing answer */
	disableBtns() {
		$('input[data-action="submit"]').prop('disabled', true);
	},
	/** Reset choice buttons to be able to select buttons again */
	resetChoiceBtns() {
		$('input[data-action="submit"]').prop('disabled', false);
		$('input[data-action="submit"]').prop('checked', false);
	},
	/**
	 * Get the choice names based on the current question
	 * @returns {Array<string>} choiceNames
	 */
	getChoiceNames() {
		let currentTrackNo = GAME.playlist.trackNo; // To determine the current track
		let currentQuestion = GAME.room.questions[currentTrackNo];
		let choiceNames = currentQuestion.choices.map((choice) => choice.displayName);
		return choiceNames;
	},
	addTextToChoiceBtns() {
		let choices = GAME.getChoiceNames();
		$('.choiceBtn').each(function (index) {
			this.textContent = choices[index];
		});
	},
};

window.GAME = GAME; // Add Game as global variable
