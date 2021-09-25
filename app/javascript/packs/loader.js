// Global variables
let bar = document.getElementById('myBar');
let progress = document.getElementById('myProgress');

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

document.addEventListener('turbolinks:load', () => {
  hideLoader();
});

document.querySelector('#startGameBtn').addEventListener('click', () => {
  showLoader();
});
