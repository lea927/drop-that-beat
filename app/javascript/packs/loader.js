/**
 * @fileoverview This contains the functions to create the progress bar/loader 
 * for the music app
 */

// ==================================================
//           FUNCTIONS
// ==================================================

export function hideLoader() {
  $('#myBar').addClass('hide');
  $('#myProgress').addClass('hide');
}

export function showLoader() {
  $('#myBar').removeClass('hide').addClass('show');
  $('#myProgress').removeClass('hide').addClass('show');
}

export function loader() {
  let loader = document.getElementById('myBar');
  let width = 1;
  let id = setInterval(frame, 300);
  function frame() {
    if (width >= 100) { return clearInterval(id) };
    width++;
    loader.style.width = width + '%';
  }
}

export function checkPlaylistStatus(playlist) {
  setInterval(function () {
    if (playlist.isPlaying === false) {
      hideLoader();
    }
  }, 1000);
}
// ==================================================
//           EVENT LISTENERS
// ==================================================

document.querySelector('#startGameBtn').addEventListener('click', () => {
  playlist.tracks.forEach((track) => {
    track.addEventListener('play', () => loader());
  });
  checkPlaylistStatus();
});
