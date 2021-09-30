import Track from './track';
/** Class representing the questions to be presented in the room */
class Question {
	/**
	 * Creates a new question class
	 * @param {Object} track track details(correct track)
	 * @param {Array<Object>} incorrectTracks array of incorrect tracks
	 */
	constructor(track, incorrectTracks) {
		this.correctTrack = Track.createCorrectTrack(track);
		this.incorrectTracks = Track.createIncorrectTrack(incorrectTracks);
		this.noOfChoices = 3;
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
	/** This creates the choices property in the object class */
	createChoices() {
		let wrongChoices = shuffle(this.incorrectTracks).slice(0, this.noOfChoices - 1); // Shuffle wrong choices so all questions will have different sets of choices
		let correctChoice = this.correctTrack;
		let choices = [...wrongChoices, correctChoice];
		this.choices = shuffle(choices);
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
