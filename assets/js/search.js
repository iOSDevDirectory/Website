document.addEventListener('DOMContentLoaded', function () {
  const searchBox = document.getElementById('search-box')
  if (!searchBox) return

  const allItems = Array.from(document.querySelectorAll('.sites li'))
  const toc = document.getElementById('table-of-contents')
  const noResults = document.getElementById('no-search-results')
  const opmlLinks = Array.from(document.getElementsByClassName('opml'))

  let store = null
  let currentTerm = ''

  function loadStore() {
    if (store) return Promise.resolve(store)
    return fetch('/search.json')
      .then(function (response) {
        if (!response.ok) throw new Error('Failed to load search data')
        return response.json()
      })
      .then(function (data) { store = data; return store })
  }

  function applyFilter(term) {
    allItems.forEach(item => item.classList.add('hidden'))
    toc.classList.add('hidden')
    opmlLinks.forEach(opml => opml.classList.add('hidden'))

    const matches = store.filter(entry =>
      entry.title.toLowerCase().includes(term) ||
      entry.author.toLowerCase().includes(term) ||
      entry.site_url.toLowerCase().includes(term)
    )

    if (matches.length > 0) {
      noResults.classList.add('hidden')
      matches.forEach(entry => document.getElementById(entry.id).classList.remove('hidden'))
    } else {
      noResults.classList.remove('hidden')
    }

    history.replaceState(null, '', '?query=' + encodeURIComponent(currentTerm))
  }

  function filterSites(query) {
    currentTerm = query.trim()
    const term = currentTerm.toLowerCase()

    if (!term) {
      allItems.forEach(item => item.classList.remove('hidden'))
      toc.classList.remove('hidden')
      noResults.classList.add('hidden')
      opmlLinks.forEach(opml => opml.classList.remove('hidden'))
      history.replaceState(null, '', window.location.pathname)
      return
    }

    loadStore()
      .then(function () {
        // Only apply if the search box hasn't changed since we started
        if (query.trim() !== currentTerm) return
        applyFilter(term)
      })
      .catch(function (error) {
        console.error(error)
        searchBox.value = ''
        searchBox.disabled = true
        searchBox.placeholder = 'Search unavailable'
      })
  }

  searchBox.addEventListener('input', function () {
    filterSites(this.value)
  })

  // Apply search from URL query parameter on initial load
  const urlParams = new URLSearchParams(window.location.search)
  const initialQuery = urlParams.get('query')
  if (initialQuery) {
    searchBox.value = initialQuery
    filterSites(initialQuery)
  }
})
