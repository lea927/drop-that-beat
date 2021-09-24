/** Class representing playlist */
class Playlist {
	/** Creates a new playlist */
	constructor(urlTracks) {
		this.trackNo = 0;
		this.tracks = [];
		this.currentTrack = '';
		this.isPlaying = false;
	}
}
