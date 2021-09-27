/**
 * Class representing list of urls for API
 */
class Url {
	/** ROOMS URLS */
	static get rooms() { return `/rooms.json` }
	static room(id) { return `/rooms/${id}.json` }

	/** TRACKS URLS */
	static get tracks() { return `/tracks.json` }
  static track(id) { return `/tracks/${id}.json` }
}
