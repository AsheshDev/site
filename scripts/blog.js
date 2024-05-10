function openModal(postId, musicPath) {
    const modal = document.getElementById('blogModal');
    const postTitle = document.getElementById('postTitle');
    const postContent = document.getElementById('postContent');
    const postMusic = document.getElementById('postMusic');

    // Example data, replace with your actual blog post data
    const posts = {
        'post1': { title: 'Blog Post Title 1', content: 'Detailed content of blog post 1...' },
        'post2': { title: 'Blog Post Title 2', content: 'Detailed content of blog post 2...' }
