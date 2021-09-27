// ==================================================
//           GLOBAL VARIABLES
// ==================================================

let bar = document.getElementById('myBar');
let progress = document.getElementById('myProgress');
// ==================================================
//           FUNCTIONS
// ==================================================

function hideLoader() {
  bar.classList.add('hide');
  progress.classList.add('hide');
}

function showLoader() {
  bar.classList.remove('hide');
  progress.classList.remove('hide');
  bar.classList.add('show');
  progress.classList.add('show');
}

function loader() {
  let i = 0;
  if (i == 0) {
    i = 1;
    let loader = document.getElementById('myBar');
    let width = 1;
    let id = setInterval(frame, 300);
    function frame() {
      if (width >= 100) {
        clearInterval(id);
        i = 0;
      } else {
        width++;
        loader.style.width = width + '%';
      }
    }
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
