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
    let correctChoice = this.track;
    let choices = [...wrongChoices, correctChoice];
    this.choices = shuffle(choices);
  }
}
