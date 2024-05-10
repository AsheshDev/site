function openModal(postId, musicPath) {
    const modal = document.getElementById('blogModal');
    const postTitle = document.getElementById('postTitle');
    const postContent = document.getElementById('postContent');
    const postMusic = document.getElementById('postMusic');

    // Example data, replace with your actual blog post data
    const posts = {
        'post1': { title: 'Blog Post Title 1', content: 'Detailed content of blog post 1...' },
        'post2': { title: 'Blog Post Title 2', content: 'Detailed content of blog post 2...' }
    };

    postTitle.innerText = posts[postId].title;
    postContent.innerText = posts[postId].content;
    postMusic.src = musicPath;

    modal.style.display = "block";

    // Close modal logic
    document.querySelector('.close').onclick = function() {
        modal.style.display = "none";
        postMusic.pause();
        postMusic.currentTime = 0;
    }
}

// Click outside modal to close it
window.onclick = function(event) {
    const modal = document.getElementById('blogModal');
    if (event.target === modal) {
        modal.style.display = "none";
        const postMusic = document.getElementById('postMusic');
        postMusic.pause();
        postMusic.currentTime = 0;
    }
}
