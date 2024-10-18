document.addEventListener('DOMContentLoaded', function() {
  var hamburger = document.querySelector('.hamburger');
  var navMenu = document.querySelector('.navigation-menu');
  hamburger.addEventListener('click', function() {
    navMenu.classList.toggle('active');
  });
});
