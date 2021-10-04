/**
 * @fileoverview Contains the properties and methods for the question
 * @requires /track.js/Track - Track class
 * @requires /api/index.js:MusicApiClient - To fetch the data from db
 */
import Track from './track';
import MusicApiClient from '../api';
/** Class representing the questions to be presented in the room */
class Question {
	/**
	 * Creates a new question class
	 * @param {Object} correctTrack track details
	 * @param {Array<Object>} incorrectTracks array of incorrect tracks
	 */
	constructor(track, incorrectTracks) {
		/** @this Question */
		this.correctTrack = Track.createCorrectTrack(track);
		this.incorrectTracks = Track.createIncorrectTrack(incorrectTracks);
		this.noOfChoices = 3;
		this.answer;
		this.choices;
		this.createChoices();
	}
	/**
	 * Create question class
	 * @param {Object} correctTrack
	 * @param {number} indexOfCorrectTrack - the index of correct class is based on the list of tracks
	 * @param {Array<Object>} tracks - tracks in the room
	 * @returns {Question} question class
	 */
	static create(correctTrack, indexOfCorrectTrack, tracks) {
		let incorrectTracks = this.getIncorrectTracks(indexOfCorrectTrack, tracks);
		return new Question(correctTrack, incorrectTracks);
	}
	/**
	 * Get incorrect tracks
	 * @param {number} indexOfCorrectTrack
	 * @param {Array<Object>} tracks
	 * @returns {Array<Object>} Object with track and incorrectTrack key
	 */
	static getIncorrectTracks(indexOfCorrectTrack, tracks) {
		let incorrectTracks = [...tracks]; // Copy to prevent mutating array
		incorrectTracks.splice(indexOfCorrectTrack, 1); // Remove correct track
		return incorrectTracks;
	}
	/**
	 * This creates the choices property in the object class
	 * Choices are shuffled everytime the function is called
	 */
	createChoices() {
		let wrongChoices = shuffle(this.incorrectTracks).slice(0, this.noOfChoices - 1); // Shuffle wrong choices so all questions will have different sets of choices
		let correctChoice = this.correctTrack;
		let choices = [...wrongChoices, correctChoice];
		this.choices = shuffle(choices);
	}
	/**
	 * Add answer based the choices selected(index)
	 * @param {number} index choice selected
	 * @returns {Question} question instance
	 */
	addAnswer(index) {
		this.answer = this.choices[index];
		return this;
	}
	/**
	 * Submit answer by sending a POST request
	 * @param {number} roomId - current room
	 * @returns {Question} question instance
	 */
	postAnswer(roomId) {
		// Check if answer is null or undefined
		if (this.answer == undefined) throw new SyntaxError('Answer not yet added');
		// Get data to be passed in the request
		const { id } = this.correctTrack; // Queston or correct track
		const { name, artist } = this.answer;
		const answer = {
			track_id: id,
			name,
			artist,
		};
		MusicApiClient.postAnswer(roomId, answer);
		return this;
	}
	getCorrectChoicesIndex() {
		return this.choices.findIndex((choice) => choice.isCorrect);
	}
}

/**
 * Shuffle elements in the array
 * @param {Array} array
 * @returns {Array} shuffled array
 */
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

export { Question, shuffle };
