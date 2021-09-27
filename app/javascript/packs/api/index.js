import trackApi from './track'
import roomApi from './room'

const MusicApiClient = {
  get rooms() { return roomApi.rooms },
  room(id) { return roomApi.room(id) },
};
