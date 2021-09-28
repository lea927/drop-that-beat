/** Class representing the room data */
class Room {
	/**
	 * Creates a new room
	 * @param {Object} room - The room to be played
	 * @param {string} room.id - The room id
	 * @param {string} room.name - The room name
	 * @param {integer} room.rounds - The number of rounds to be played
	 * @param {Array<object>} room.tracks - The tracks in the room
	 */
	constructor({ id, name, rounds, tracks } = {}) {
		this.id = id;
		this.name = name;
		this.rounds = rounds;
		this.tracks = tracks;
	}
}
