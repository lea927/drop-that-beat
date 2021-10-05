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
	answerDisplay: {
		true: {
			classColor: 'btn-success',
			message: 'Correct answer',
		},
		false: {
			classColor: 'btn-danger',
			message: 'Incorrect Answer',
		},
	},
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
			GAME.hideGame();
			Turbolinks.clearCache();
		});
		document.addEventListener('turbolinks:before-cache', () => {
			// Turbolinks won't cache the playing playlist
			GAME.endGame();
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
				GAME.disableBtns();
				GAME.displayAnswer();
				setTimeout(GAME.displayNextQuestion, 3000);
			});
		});
		GAME.playlist.lastTrack.addEventListener('ended', () => {
			setTimeout(() => {
				GAME.hideGame();
				$('#startGameBtn').attr('style', 'display:none');
				$('#endGame').removeClass('d-none');
			}, 3000);
		});
	},
	addChoiceBtnListener() {
		$('input[data-action="submit"]').on('click', (evt) => {
			evt.target.dataset.answer = 'true';
			GAME.saveAnswer({
				index: evt.target.value, // index of button clicked
				currentTrackData: GAME.getCurrentQuestion(),
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
		$('#question').prop('style', 'visibility: hidden');
		$('#startGameBtn').attr('style', 'display:block');
		LOADER.hideLoader();
	},
	displayNextQuestion() {
		GAME.resetAnswer();
		GAME.resetChoiceBtns();
		GAME.playlist.next();
	},
	/**
	 * Get current track details
	 * @returns {Question} current question
	 */
	getCurrentQuestion() {
		let trackNo = GAME.playlist.trackNo; // Currently playing track number
		return GAME.room.questions[trackNo];
	},
	/** Save answer to database */
	saveAnswer({ index, currentTrackData }) {
		if (index == undefined || currentTrackData == undefined) throw new SyntaxError('Object does not have index or currentTrackData property');
		currentTrackData.addAnswer(index).postAnswer(GAME.room.id);
	},
	getAnswer() {
		if (GAME.getCurrentQuestion().answer == undefined) return undefined;
		return GAME.getCurrentQuestion().answer.isCorrect;
	},
	displayAnswer() {
		// Styles
		let answer = GAME.getAnswer();
		let result = answer ?? false;
		let { classColor, message } = GAME.answerDisplay[result];
		// Header
		$('#question').addClass('d-none');
		$('[data-display="answer"]').removeClass('d-none').text(message);
		// Buttons
		if (answer !== undefined) {
			$('[data-answer="true"]').next().removeClass('btn-primary').addClass(classColor);
		} else {
			let index = GAME.getCurrentQuestion().getCorrectChoicesIndex();
			$('.choiceBtn').eq(index).removeClass('btn-primary').addClass(classColor);
		}
	},
	resetAnswer() {
		// Header
		$('[data-display="answer"]').addClass('d-none');
		$('#question').removeClass('d-none');
		// Buttons
		$('[data-answer]').attr('data-answer', 'false').next().removeClass('btn-success btn-danger').addClass('btn-primary');
	},
	updatePointsNavbar() {
		let result = GAME.getAnswer() ?? false; // If no answer provided, the answer is incorrect
		let navBarPoints = document.querySelector("[data-update='points']");
		if (!result) return;
		navBarPoints.textContent = parseInt(navBarPoints.textContent) + 1;
	},
	displayTotalPoints() {
		let points = GAME.getTotalPoints();
		let messagePoint = points > 1 ? 'points' : 'point';
		let message = points > 0 ? 'Congratulations!' : 'Try again next time';
		points > 0 && $('[data-display="points"]').html(`You have earned ${points} ${messagePoint}<br>${message}`);
		points === 0 && $('[data-display="points"]').html(`No points earned.<br>${message}`);
	},
	getTotalPoints() {
		// Check if there is an answer and answer is correct
		return GAME.room.questions.filter(({answer}) => answer && answer.isCorrect).length;
	},
	/** Disable buttons to prevent changing answer */
	disableBtns() {
		$('input[data-action="submit"]').prop('disabled', true);
	},
	/** Reset choice buttons to be able to select buttons again */
	resetChoiceBtns() {
		$('#choices').hide().fadeIn(500);
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
