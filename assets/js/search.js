window.store = []

window.addEventListener('load', function() {
    const urlParams = new URLSearchParams(window.location.search);
    const searchTerm = urlParams.get('query')

    if (searchTerm) {
        document.getElementById('search-box').setAttribute("value", searchTerm);

        const idx = lunr(function () {
            this.ref('id') // Auto-incremented ID for each blog
            // The fields we want to search by
            this.field('title')
            this.field('author')

            window.store.forEach(blog => this.add(blog))
        });

        // Hide all the blogs to start
        Array.from(document.getElementsByClassName('sites').item(0).getElementsByTagName("li")).forEach(blog => {
            blog.classList.add("hidden")
        })

        // Hide the table of contents & stats
        document.getElementById('table-of-contents').classList.add("hidden")

        // Hide the OPML links when it's not guaranteed that all links are shown
        Array.from(document.getElementsByClassName('opml')).forEach(opml => {
            opml.classList.add("hidden")
        })

        const results = idx.search(searchTerm)
        if (results.length > 0) {
            // Iterate over the matches and make them visible
            for (let i = 0; i < results.length; i++) {
                const item = window.store.find(blog => blog.id === results[i].ref);
                document.getElementById(item.id).classList.remove("hidden")
            }
        } else {
            document.getElementById('no-search-results').classList.remove("hidden");
        }
    }
})
