/**
 * @fileoverview Functions to get rooms and post answers in the room
 *
 * @requires ./request.js/ - request functions
 * @requires ./url.js:Url - endpoints for the request
 */
import { get, post } from './request';
import Url from './url';

/** @module roomsApi */
const roomsApi = {
	/**
	 * Fetch all rooms in the database
	 * @return {Promise} - all rooms
	 */
	get rooms() { return get(Url.rooms) },
	/**
	 * Fetch a single room in the database
	 * @param {number} id
	 * @returns {Promise} room information
	 */
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
	/**
	 * Checks if current window is the rooms_path (/rooms/:id)
	 * @returns {boolean} window path name
	 */
	isInRoomPath() { return window.location.pathname.includes('rooms') },
	/**
	 * Gets the room id from the window pathname
	 * @returns {number} room id
	 */
	getRoomIdFromPath() { return window.location.pathname.split('rooms').pop() },
	/**
	 * Sets default room id if the user is in the rooms path
	 * @returns {number} room id
	 */
	setDefaultRoomId() {
		if (roomsApi.isInRoomPath()) return roomsApi.getRoomIdFromPath();
	},
};

/*** @exports api/room Connect with room model in music app*/
export default roomsApi;
