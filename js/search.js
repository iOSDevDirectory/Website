(function() {
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
            // Hide all of the blog <li>'s in O(1) via CSS rules
            let element = document.createElement('style'), sheet;
            document.head.appendChild(element);
            sheet = element.sheet;
            sheet.insertRule('.sites li { display: none }', 0);

            // OPML links should be hidden when not all their contents are guaranteed to be visible
            sheet.insertRule('.opml { display: none }', 0);

            // Iterate over the matches and make them visible
            for (let i = 0; i < results.length; i++) {
                const item = window.store[results[i].ref];
                document.getElementById(item.id).classList.add("visible")
            }

            // Hide the table of contents & stats
            document.getElementById('tableOfContents').classList.add("hidden")

            // Hide any categories that have no results
            let categories = document.getElementsByClassName("category-wrapper")
            for (let i = 0; i < categories.length; i++) {
                let currCat = categories.item(i)
                let blogsUL = currCat.children.item(currCat.children.length - 1)

                // Hide category if there are no visible blogs
                if (Array.from(blogsUL.children).every(child => !child.classList.contains("visible"))) {
                    currCat.classList.add("hidden")
                }
            }

            // Hide any languages that have no results
            let languages = document.getElementsByClassName("language-wrapper")
            for (let i = 0; i < languages.length; i++) {
                let currLang = languages.item(i)
                let categoriesContainer = currLang.children.item(currLang.children.length - 1)

                // Hide language if all categories are hidden
                if (Array.from(categoriesContainer.children).every(child => child.classList.contains("hidden"))) {
                    currLang.classList.add("hidden")
                }
            }
        } else {
            document.getElementById('no-search-results').classList.add("visible");
        }
    }
})();
