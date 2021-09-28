/** Class representing the tracks */
class Track {
	/**
	 * Creates a new track
	 * @param {Object} track - the track object
	 * @param {number} track.id
	 * @param {string} track.name
	 * @param {string} track.artist
	 * @param {string} track.adam_id
	 * @param {string} track.preview_url
	 * @param {boolean} isCorrect
	 */
	constructor({ id, name, artist, adam_id, preview_url }, isCorrect) {
		this.id = id;
		this.name = name;
		this.artist = artist;
		this.adam_id = adam_id;
		this.preview_url = preview_url;
		this.isCorrect = isCorrect;
	}
	/**
	 * Creates a correct track by setting isCorrect property to true
	 * @param {Object} track track object
	 * @returns {Track}
	 */
	static createCorrectTrack(track) {
		return new Track(track, (isCorrect = true));
	}
	/**
	 * Creates array of incorrect track by setting isCorrect property to false
	 * @param {Array<Object>} tracks - array of incorrect tracks
	 * @returns {Array<Track>} array of incorrect track class
	 */
	static createIncorrectTrack(tracks) {
		let incorrectTracks = [];
		tracks.forEach((track) => {
			incorrectTracks.push(new Track(track, (isCorrect = false)));
		});
		return incorrectTracks;
	}
}
export default Track;
