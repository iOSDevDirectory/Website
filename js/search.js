window.store = []

window.onload = function() {
    function getQueryVariable(variable) {
        const query = window.location.search.substring(1);
        const vars = query.split('&');

        for (let i = 0; i < vars.length; i++) {
            const pair = vars[i].split('=');

            if (pair[0] === variable) {
                return decodeURIComponent(pair[1].replace(/\+/g, '%20'));
            }
        }
    }

    const searchTerm = getQueryVariable('query');

    if (searchTerm) {
        document.getElementById('search-box').setAttribute("value", searchTerm);

        const idx = lunr(function () {
            this.ref('id') // Auto-incremented ID for each blog
            // The fields we want to search by
            this.field('title')
            this.field('author')

            window.store.forEach(blog => this.add(blog))
        });

        const results = idx.search(searchTerm)
        if (results.length > 0) {
            // Hide all the blogs to start
            Array.from(document.getElementsByClassName('sites').item(0).getElementsByTagName("li")).forEach(blog => {
                blog.classList.add("hidden")
            })

            // Iterate over the matches and make them visible
            for (let i = 0; i < results.length; i++) {
                const item = window.store.find(blog => blog.id === results[i].ref);
                document.getElementById(item.id).classList.remove("hidden")
            }

            // Hide the table of contents & stats
            document.getElementById('tableOfContents').classList.add("hidden")

            // Hide the OPML links when it's not guaranteed that all links are shown
            Array.from(document.getElementsByClassName('opml')).forEach(opml => {
                opml.classList.add("hidden")
            })
        } else {
            document.getElementById('no-search-results').classList.add("visible");
        }
    }
}
