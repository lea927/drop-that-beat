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

	/** ANSWER URL */
	static answer(roomId) { return `/rooms/${roomId}` }
}
/*** @exports api/url Connect with room model in music app*/
export default Url;
