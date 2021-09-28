/** Class representing the questions to be presented in the room */
class Question {
  /**
   * Creates a new question class
   * @param {Object} track track details(correct track)
   * @param {Array<Object>} incorrectTracks array of incorrect tracks
   */
  constructor(track, incorrectTracks) {
    this.track = track;
    this.incorrectTracks = incorrectTracks;
  }
}
