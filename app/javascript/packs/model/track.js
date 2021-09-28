/** Class representing the tracks */
class Track {
  /**
   * Creates a new track
   * @param {Object} track - the track object
   * @param {number} track.id
   * @param {string} track.name 
   * @param {string} track.artist 
   * @param {string} track.adam_id 
   * @param {string} track.preview_url 
   * @param {boolean} isCorrect
   */
   constructor({ id, name, artist, adam_id, preview_url }, isCorrect ) {
    this.id = id;
    this.name = name;
    this.artist = artist;
    this.adam_id = adam_id;
    this.preview_url = preview_url;
    this.isCorrect = isCorrect;
  }
}
