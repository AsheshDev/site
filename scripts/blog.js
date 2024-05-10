document.addEventListener('DOMContentLoaded', function() {
    const modal = document.getElementById('blogModal');
    const closeBtn = document.querySelector('.close');
    const bgMusic = new Audio('audio/terrablogbgm.mp3'); // Background music for the blog
    const postMusic = document.getElementById('postMusic');
    const audioCtx = new (window.AudioContext || window.webkitAudioContext)();
    let audioSource = null;
    let analyser = null;

    function openModal() {
        const postTitle = document.getElementById('postTitle');
        const postContent = document.getElementById('postContent');
        const audioThumbnail = document.getElementById('audioThumbnail');
        const audioTitle = document.getElementById('audioTitle');
        const audioAuthor = document.getElementById('audioAuthor');

        // Setting up audio and text details
        postTitle.innerText = "Brothers Not by Blood, But by Destiny: The Tale of Terra and Black Snow";
        postContent.innerHTML = `<p>In the grand narrative of life, there are bonds that transcend the mere ties of blood—connections forged in the fires of shared experiences and mutual dreams. This is the chronicle of Terra and myself, Black Snow, also known as Ashesh. While we do not share a lineage, our spirits are intertwined, our destinies shaped by the choices we have made and the paths we have chosen to walk together.</p>
        <p>Our adventure began not with a grand event, but with a serendipitous encounter in the virtual realms of Ark Survival Evolved. I was a nomad, hopping from one server to another in pursuit of new challenges, and Terra was a lone wolf, mastering the game in solitude. It was this chance meeting that kindled the flames of an enduring friendship.</p>
        <p>Together, we embarked on the creation of our own servers, a dream that extended beyond the confines of the virtual world. The endeavor was a testament to our partnership—a symphony of Terra's visionary ideas and my coding prowess.</p>
        <p>The journey was fraught with obstacles. Our initial forays into server management were met with setbacks. We trusted in hosting services that let us down, yet it was Terra's bravery and my technical skills that eventually turned the tide. By deciding to host the server from his home, Terra laid the foundation for what would become our shared legacy.</p>
        <p>Three years have elapsed since that pivotal decision. We have faced trials that tested the very essence of our partnership, moments that nearly drove us apart. Yet, our bond, much like the virtual worlds we crafted, has proven resilient. Now, we stand not just as friends but as co-creators, joined by Trent, as we develop our game and weave our dreams into reality.</p>
        <p>Despite the intimacy we have developed, Terra and I have yet to meet in person. He resides on the opposite side of the world, a full 12 hours away. Nevertheless, our connection has bridged the physical divide, demonstrating that proximity is not a prerequisite for heartfelt ties.</p>
        <p>Here's to Terra, my brother not by blood but by destiny. To the memories we have forged, the challenges we have overcome, and the future we are yet to create.</p>`;

        audioThumbnail.src = 'path/to/audio-thumbnail.jpg'; // Path to the audio thumbnail
        audioTitle.innerText = 'Terra and Black Snow';
        audioAuthor.innerText = 'Black Snow aka Ashesh';
        postMusic.src = 'https://suno.com/song/06207a16-eb8e-440b-ab68-c6f42a093d2a'; // Update the specific audio for the post

        modal.style.display = "block";
        bgMusic.play();
        setupAudioVisualizer();
    }

    function closeModal() {
        modal.style.display = "none";
        bgMusic.pause();
        bgMusic.currentTime = 0;
        if (audioSource !== null) {
            audioSource.disconnect();
            analyser.disconnect();
            audioSource = null;
            analyser = null;
        }
        audioCtx.suspend();
        postMusic.pause();
        postMusic.currentTime = 0;
    }

    function setupAudioVisualizer() {
        if (audioSource === null) {
            audioSource = audioCtx.createMediaElementSource(postMusic);
            analyser = audioCtx.createAnalyser();
            audioSource.connect(analyser);
            analyser.connect(audioCtx.destination);

            analyser.fftSize = 256;
            const bufferLength = analyser.frequencyBinCount;
            const dataArray = new Uint8Array(bufferLength);
            const canvas = document.getElementById('audioVisualizer');
            const canvasCtx = canvas.getContext('2d');

            function draw() {
                requestAnimationFrame(draw);
                analyser.getByteFrequencyData(dataArray);

                canvasCtx.fillStyle = 'rgb(0, 0, 0)';
                canvasCtx.fillRect(0, 0, canvas.width, canvas.height);

                let barWidth = (canvas.width / bufferLength) * 2.5;
                let barHeight;
                let x = 0;

                for(let i = 0; i < bufferLength; i++) {
                    barHeight = dataArray[i];
                    canvasCtx.fillStyle = 'rgb(' + (barHeight+100) + ', 50, 50)';
                    canvasCtx.fillRect(x, canvas.height - barHeight / 2, barWidth, barHeight / 2);

                    x += barWidth + 1;
                }
            }

            draw();
        }
    }

    document.querySelector('.blog-container').addEventListener('click', openModal);
    closeBtn.addEventListener('click', closeModal);
    window.addEventListener('click', function(event) {
        if (event.target == modal) {
            closeModal();
        }
    });
});
