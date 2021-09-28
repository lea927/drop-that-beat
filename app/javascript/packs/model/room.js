/** Class representing the room data */
class Room {
	/**
	 * Creates a new room
	 * @param {string} id - The room id
	 * @param {string} name - The room name
   * @param {integer} rounds - The number of rounds to be played
   * @param {Array<object>} tracks - The tracks in the room
	 */
	constructor(id, name, rounds, tracks) {
		this.id = id;
		this.name = name;
		this.rounds = rounds;
		this.tracks = tracks;
	}
}
