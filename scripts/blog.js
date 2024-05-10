function openModal(postElement) {
    const modal = document.getElementById('blogModal');
    const postTitle = document.getElementById('postTitle');
    const postContent = document.getElementById('postContent');
    const postMusic = document.getElementById('postMusic');

    postTitle.innerText = postElement.querySelector('h2').innerText;
    postContent.innerText = postElement.querySelector('p').innerText;
    postMusic.src = postElement.getAttribute('data-audio');

    modal.style.display = "block";

    document.querySelector('.close').onclick = function() {
        modal.style.display = "none";
        postMusic.pause();
        postMusic.currentTime = 0;
    };

    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
            postMusic.pause();
            postMusic.currentTime = 0;
        }
    };
}
