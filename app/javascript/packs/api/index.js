import trackApi from './track'
import roomApi from './room'

const MusicApiClient = {
  get rooms() { return roomApi.rooms },
  room(id) { return roomApi.room(id) },
  get tracks() { return trackApi.tracks },
  track(id) { return trackApi.track(id) },
  postAnswer(roomId, data) { return roomApi.postAnswer(roomId, data) },
};
window.client = MusicApiClient;
export default MusicApiClient;