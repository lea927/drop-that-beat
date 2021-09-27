import { get } from './request';
import Url from './url';

/**
 * @module api/track
 */
const trackApi = {
  get tracks() { return get(Url.tracks) },
};
