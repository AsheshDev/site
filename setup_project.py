import os

# Define the directories to create
directories = [
    'styles',
    'scripts',
    'music'  # Assuming music files are managed here
]

# Define the files and their initial content
files = {
    'blog.html': """<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tantra Genesis M Blog</title>
    <link rel="stylesheet" href="styles/blog.css">
</head>
<body>
    <div class="blog-container">
        <h1>Tantra Genesis M Blog</h1>
        <div class="post" onclick="openModal('post1', 'music/blog1.mp3')">
            <h2>Blog Post Title 1</h2>
            <p>Summary of blog post content...</p>
        </div>
        <div class="post" onclick="openModal('post2', 'music/blog2.mp3')">
            <h2>Blog Post Title 2</h2>
            <p>Summary of blog post content...</p>
        </div>
    </div>
    <div id="blogModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2 id="postTitle"></h2>
            <p id="postContent"></p>
            <audio controls autoplay>
                <source id="postMusic" src="" type="audio/mpeg">
            </audio>
        </div>
    </div>
    <script src="scripts/blog.js"></script>
</body>
</html>""",
    'styles/blog.css': """body, html {
    margin: 0; padding: 0; box-sizing: border-box; font-family: 'Arial', sans-serif; background-color: #000; color: #fff;
}
.blog-container {
    max-width: 1200px; margin: 20px auto;
}
.post {
    background-color: #333; margin-bottom: 10px; padding: 10px; cursor: pointer; color: #fff;
}
.modal {
    display: none; position: fixed; z-index: 1; left: 0; top: 0; width: 100%; height: 100%; overflow: auto; background-color: rgba(0, 0, 0, 0.9);
}
.modal-content {
    background-color: #222; margin: 15% auto; padding: 20px; border: 1px solid #880000; width: 80%;
}
.close {
    color: #aaa; float: right; font-size: 28px; font-weight: bold; cursor: pointer;
}
.close:hover, .close:focus {
    color: #cc0000; text-decoration: none; cursor: pointer;
}
audio {
    width: 100%;
}""",
    'scripts/blog.js': """function openModal(postId, musicPath) {
    const modal = document.getElementById('blogModal');
    const postTitle = document.getElementById('postTitle');
    const postContent = document.getElementById('postContent');
    const postMusic = document.getElementById('postMusic');

    const posts = {
        'post1': { title: 'Blog Post Title 1', content: 'Detailed content of blog post 1...' },
        'post2': { title: 'Blog Post Title 2', content: 'Detailed content of blog post 2...' }
    };

    postTitle.innerText = posts[postId].title;
    postContent.innerText = posts[postId].content;
    postMusic.src = musicPath;

    modal.style.display = "block";

    document.querySelector('.close').onclick = function() {
        modal.style.display = "none";
        postMusic.pause();
        postMusic.currentTime = 0;
    }

    window.onclick = function(event) {
        if (event.target === modal) {
            modal.style.display = "none";
            postMusic.pause();
            postMusic.currentTime = 0;
        }
    }
}"""
}

for directory in directories:
    if not os.path.exists(directory):
        os.makedirs(directory)
        print(f'Created directory: {directory}')
    else:
        print(f'Directory already exists: {directory}')

# Check each file path, create and write content if the file does not exist
for file_path, content in files.items():
    full_path = os.path.join('.', file_path)
    if not os.path.exists(full_path):
        with open(full_path, 'w', encoding='utf-8') as file:
            file.write(content)
            print(f'Created file: {full_path}')
    else:
        print(f'File already exists and was not overwritten: {full_path}')
