import { get } from './request';
import Url from './url';

/**
 * @module api/track
 */
const trackApi = {
  get tracks() { return get(Url.tracks) },
  track(id) {
    if (!id) throw new Error('Missing track id argument'); 
		return get(Url.track(id));
	},
};

/*** @exports api/track Connect with room model in music app*/
export default trackApi;
