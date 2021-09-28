/** Class representing the room data */
class Room {
	/**
	 * Creates a new room
	 * @param {string} id - The room id
	 * @param {string} name - The room name
   * @param {integer} rounds - The number of rounds to be played
	 */
	constructor(id, name, rounds) {
		this.id = id;
		this.name = name;
		this.rounds = rounds;
	}
}
