/** Class representing the questions to be presented in the room */
class Question {
	/**
	 * Creates a new question class
	 * @param {Object} track track details(correct track)
	 * @param {Array<Object>} incorrectTracks array of incorrect tracks
	 */
	constructor(track, incorrectTracks) {
		this.track = track;
		this.incorrectTracks = incorrectTracks;
		this.noOfChoices = 3;
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
}
