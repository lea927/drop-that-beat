/*** XHR Requests module
 * @module api/request */
/**
 * Run async get request
 * @param {string} path
 * @param {Object} options
 * @returns {Promise} Promise object representing XHR result
 */
export function get(path, { data, successCallback, errorCallback } = {}) {
	return $.get({
		url: path,
		dataType: 'json',
		data,
		success: function (data) {
			successCallback && successCallback(data);
			return data;
		},
		error: function (request, errorMsg) {
			errorCallback && errorCallback();
			console.log(request, errorMsg);
		},
	});
}
