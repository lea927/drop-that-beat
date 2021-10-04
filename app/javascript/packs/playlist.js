/** Class representing playlist */
class Playlist {
  /**
   * Creates a new playlist
   * @param {Array<string>} urlTracks Array of preview url
   */
  constructor(urlTracks) {
    this.trackNo = 0;
    this.tracks = [];
    this.isPlaying = false;
    this.currentTrack;
    this.lastTrack;
    this.createTrack(urlTracks);
    this.setLastTrack();
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
  setLastTrack() {
    return this.lastTrack = this.tracks[this.tracks.length - 1];
  }
  reset() {
    this.currentTrack = '';
    this.trackNo = 0;
    this.isPlaying = false;
    return this;
  }
  /**
   * Play audio track. Track number is automatically determined
   * @returns {Playlist}
   */
  play() {
    this.tracks[this.trackNo].play();
    this.currentTrack = this.tracks[this.trackNo];
    this.isPlaying = true;
    return this;
  }
  /**
   * Pause audio track.
   * @returns {Playlist}
   */
  pause() {
    this.tracks[this.trackNo].pause();
    this.isPlaying = false;
    return this;
  }
  /**
   * End audio track.
   * @returns {Playlist}
   */
  end() {
    this.tracks[this.trackNo].load();
    this.reset();
    return this;
  }
  /**
   * Next Track
   * @returns {Playlist}
   */
  next() {
    let isLastTrack = this.trackNo === this.tracks.length - 1;
		this.tracks[this.trackNo].load();
		if (isLastTrack) return this.end();
		return this.nextTrackNo().play();
  }
  /**
   * Sets the track number to the next track
   * @returns {Playlist}
   */
   nextTrackNo() {
    let isLastTrack = this.trackNo === this.tracks.length - 1;
    if (isLastTrack) { // if last track
      this.trackNo = 0;  
    } else {
      this.trackNo++ // next track
    }
    return this;
  }
}

export default Playlist;
