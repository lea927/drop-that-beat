import { get } from './request';
import Url from './url';

const roomsApi = {
  get rooms() { return get(Url.rooms) },
};
