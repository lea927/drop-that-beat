/** Class representing the tracks */
class Track {
  /**
   * Creates a new track
   * @param {number} id 
   * @param {string} name 
   * @param {string} artist 
   * @param {string} adam_id 
   * @param {string} preview_url 
   * @param {boolean} isCorrect 
   */
  constructor(id, name, artist, adam_id, preview_url, isCorrect ) {
    this.id = id;
    this.name = name;
    this.artist = artist;
    this.adam_id = adam_id;
    this.preview_url = preview_url;
    this.isCorrect = isCorrect;
  }
}
