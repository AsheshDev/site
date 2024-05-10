// Function to start playing music when the user interacts with the page
function playMusic() {
  var music = document.getElementById('background-music');
  if (music.paused) {
    music.play();
  }
}

// Event listener for play button
document.addEventListener('click', playMusic);

// Function to create an infinite loop for the roadmap
function setupRoadmapLoop() {
  const roadmap = document.querySelector('.roadmap-container');
  const items = document.querySelectorAll('.roadmap-item');
  const totalWidth = Array.from(items).reduce((total, item) => total + item.offsetWidth, 0);
  
  roadmap.scrollLeft = 0;
  let scrollAmount = 0;

  function scrollRoadmap() {
    scrollAmount += 2; // Speed of the scroll
    if (scrollAmount >= totalWidth) {
      scrollAmount = 0;
    }
    roadmap.scrollLeft = scrollAmount;
    window.requestAnimationFrame(scrollRoadmap);
  }

  window.requestAnimationFrame(scrollRoadmap);
}

// Call the function to set up the roadmap loop
setupRoadmapLoop();

// Function to handle horizontal scrolling with mouse wheel
function horizontalScroll(event) {
  event.preventDefault();
  const scrollContainer = event.target.closest('.horizontal-scroll');
  if (scrollContainer) {
    scrollContainer.scrollLeft += event.deltaY;
  }
}

// Add mouse wheel event listener
document.addEventListener('wheel', horizontalScroll, { passive: false });
