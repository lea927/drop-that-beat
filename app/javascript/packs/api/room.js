import { get, post } from './request';
import Url from './url';

const roomsApi = {
  get rooms() { return get(Url.rooms) },
  room(id = roomsApi.setDefaultRoomId()) {
    if (!id) throw new Error('Missing room id argument'); // Not in rooms path and no id is indicated
		return get(Url.room(id));
	},
	/**
	 * Post answers which adds points to the user
	 * @param {number} roomId
	 * @param {Object} data
	 * @returns {Promise} result of the request ({boolean} true if the answer is correct )
	 */
   postAnswer(roomId, data) {
		let path = Url.answer(roomId);
		return post(path, { data: data });
	},
  isInRoomPath() { return window.location.pathname.includes('rooms') },
  getRoomIdFromPath() { return window.location.pathname.split('rooms').pop() },

  setDefaultRoomId() {
		if (roomsApi.isInRoomPath()) return roomsApi.getRoomIdFromPath();
	},
};

/*** @exports api/room Connect with room model in music app*/
export default roomsApi;
