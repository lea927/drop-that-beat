import { get } from './request';
import Url from './url';

const roomsApi = {
  get rooms() { return get(Url.rooms) },
  room(id) { return get(Url.room(id)) },
  isInRoomPath() { return window.location.pathname.includes('rooms') },
  getRoomIdFromPath() { return window.location.pathname.split('rooms').pop() },

  setDefaultRoomId() {
		if (roomsApi.isInRoomPath()) return roomsApi.getRoomIdFromPath();
	},
};
