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
    this.currentTrack = '';
    this.trackNo = 0;
    this.isPlaying = false;
    return this;
  }
  /**
   * Next Track
   * @returns {Playlist}
   */
  next() {
    this.tracks[this.trackNo].load();
    this.nextTrackNo();
    if (this.trackNo === 0) {
      this.end();
      return;
    }
    this.play();
    return this;
  }
  /**
   * Sets the track number to the next track
   * @returns {Playlist}
   */
  nextTrackNo() {
    if (this.trackNo < this.tracks.length - 1) {
      this.trackNo++;
    } else {
      this.trackNo = 0;
    }
    return this;
  }
}

export default Playlist;
