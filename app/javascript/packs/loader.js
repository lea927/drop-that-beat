
// ==================================================
//           FUNCTIONS
// ==================================================

function hideLoader() {
  $('#myBar').addClass('hide');
  $('#myProgress').addClass('hide');
}

function showLoader() {
  $('#myBar').removeClass('hide').addClass('show');
  $('#myProgress').removeClass('hide').addClass('show');
}

function loader() {
  let loader = document.getElementById('myBar');
  let width = 1;
  let id = setInterval(frame, 300);
  function frame() {
    if (width >= 100) { return clearInterval(id) };
    width++;
    loader.style.width = width + '%';
  }
}

function checkPlaylistStatus() {
  setInterval(function () {
    if (playlist.isPlaying === false) {
      hideLoader();
    }
  }, 1000);
}
// ==================================================
//           EVENT LISTENERS
// ==================================================

document.addEventListener('turbolinks:load', () => {
  hideLoader();
});
document.querySelector('#startGameBtn').addEventListener('click', () => {
  showLoader();
  playlist.tracks.forEach((track) => {
    track.addEventListener('play', () => loader());
  });
  checkPlaylistStatus();
});
