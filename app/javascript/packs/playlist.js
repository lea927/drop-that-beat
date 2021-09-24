/** Class representing playlist */
class Playlist {
	/**
	 * Creates a new playlist
	 * @param {Array<string>} urlTracks Array of preview url
	 */
	constructor(urlTracks) {
		this.trackNo = 0;
		this.tracks = [];
		this.currentTrack = '';
		this.isPlaying = false;
		this.createTrack(urlTracks);
	}
	/**
	 * Setup playlist tracks
	 * @param {Array<string>} urlTracks
	 * @returns {Array.<Object>} Array of audio objects
	 */
	createTrack(urlTracks) {
		urlTracks.forEach((urlTrack) => {
			let track = new Audio(urlTrack);
			track.addEventListener('ended', () => this.next());
			this.tracks.push(track);
		});
		return this.tracks;
	}
}
