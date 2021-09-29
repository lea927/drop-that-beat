import Question from './question';

/** Class representing the room data */
class Room {
	/**
	 * Creates a new room
	 * @param {Object} room - The room to be played
	 * @param {number} room.id - The room id
	 * @param {string} room.name - The room name
	 * @param {number} room.rounds - The number of rounds to be played
	 * @param {Array<object>} room.tracks - The tracks in the room
	 */
	constructor({ id, name, rounds, tracks } = {}) {
		this.id = id;
		this.name = name;
		this.rounds = rounds;
		this.tracks = tracks;
		this.questions = [];
		this.createQuestions(tracks);
	}
	get tracksUrl() {
		return this.tracks.map((track) => track.preview_url);
	}
	/**
	 * Creates incorrect tracks(i.e., tracks aside from the current tracks)
	 * Given tracklist ['IDGAF', 'Levitating', 'Break My Heart'] with current track 'IDGAF'
	 * the incorrect tracks are ['Levitating', 'Break My Heart']
	 * @param {Array} ArrayofTracks
	 * @returns {Array<Question>} populates the questions for the room
	 */
	createQuestions(tracks) {
		let questions = [];
		tracks.forEach((track, index, tracks) => {
			questions.push(Question.create(track, index, tracks));
		});
		this.questions = questions;
	}
}
export default Room;

