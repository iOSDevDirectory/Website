---
layout: default
permalink: /contributing/
title: iOS Dev Directory - Contributing
---

# Adding a site to the iOS Dev Directory

Is there something missing from this directory? Here's everything you need to know to get it added.

## Guidelines for adding a site or blog

Ideally, only sites relevant to Apple platform or Swift development will be added to this directory, although that includes *all* aspects of development, including design, marketing, business, and everything else. However, if your site includes other topics too, it is still welcome! If your blog covers multiple topics and supports tags/categories for filtering, adding filtered feeds really helps.

For example if you post mainly about Swift development, occasionally about iOS design and sometimes about other topics, the best solution would be to do this:

* Add a link to your site's development related posts to the development category.
* Add a link to your site's design related posts to the design category.
* Leave out the other categories from your site.

If that is not possible because your blog software doesn't support categories, that's still OK! I'd like this site to lean towards inclusion and so if your blog is partially about something related to iOS development and partially about something else, submit it anyway!

If you think there's a category missing or want to suggest a bigger change to the site, [open an issue](https://github.com/daveverwer/iOSDevDirectory/issues/new).

## Multiple languages

This site supports multiple languages, and categories within those languages. If your blog or site is written in a language that has not yet been added, please feel free to add that language in `blogs.json` and the site will automatically be expanded to include it.

## How to contribute

These simple instructions should be everything you need to get a new site included in the directory:

1. Fork [this repository](https://github.com/iOSDevDirectory/iOSDevDirectory) on GitHub.
2. Edit [blogs.json](https://github.com/iOSDevDirectory/iOSDevDirectory/blob/main/blogs.json) and add your site. See below for the details of the JSON format.
3. Submit a pull request.

Once the pull request is accepted and merged, the site will update and your link will appear! Thank you for wanting to contribute.

## Adding your site

Your site should be added as a JSON dictionary in the correct category. Here's an example entry:

```json
{
  "title": "John Appleseed's Blog",
  "author": "John Appleseed",
  "site_url": "https://example.com",
  "feed_url": "https://example.com/feed.xml",
  "bluesky_url": "https://bsky.app/profile/appleseed.bsky.social",
  "mastodon_url": "https://mastodon.social/@appleseed",
  "threads_url": "https://www.threads.net/@appleseed",
  "x_url": "https://x.com/appleseed",
  "github_url": "https://github.com/appleseed",
  "linkedin_url": "https://www.linkedin.com/in/appleseed",
  "microblog_url": "https://micro.blog/appleseed",
  "weibo_url": "https://weibo.com/appleseed"
}
```

### Field reference

<table class="fields-table">
  <thead>
    <tr>
      <th>Field</th>
      <th>Description</th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>title</code></td>
      <td>The title of the blog/site. For personal blogs, use "John Appleseed's Blog".</td>
      <td><span class="badge required">Required</span></td>
    </tr>
    <tr>
      <td><code>author</code></td>
      <td>Author name or names.</td>
      <td><span class="badge required">Required</span></td>
    </tr>
    <tr>
      <td><code>site_url</code></td>
      <td>URL to the web version of the blog/site.</td>
      <td><span class="badge required">Required</span></td>
    </tr>
    <tr>
      <td><code>feed_url</code></td>
      <td>URL to the RSS/Atom feed.</td>
      <td><span class="badge optional">Optional</span></td>
    </tr>
    <tr>
      <td><code>bluesky_url</code></td>
      <td>Bluesky profile URL.</td>
      <td><span class="badge optional">Optional</span></td>
    </tr>
    <tr>
      <td><code>mastodon_url</code></td>
      <td>Mastodon profile URL.</td>
      <td><span class="badge optional">Optional</span></td>
    </tr>
    <tr>
      <td><code>threads_url</code></td>
      <td>Threads profile URL.</td>
      <td><span class="badge optional">Optional</span></td>
    </tr>
    <tr>
      <td><code>x_url</code></td>
      <td>Twitter/X profile URL.</td>
      <td><span class="badge optional">Optional</span></td>
    </tr>
    <tr>
      <td><code>github_url</code></td>
      <td>GitHub profile URL.</td>
      <td><span class="badge optional">Optional</span></td>
    </tr>
    <tr>
      <td><code>linkedin_url</code></td>
      <td>LinkedIn profile URL.</td>
      <td><span class="badge optional">Optional</span></td>
    </tr>
    <tr>
      <td><code>microblog_url</code></td>
      <td>Micro.blog profile URL.</td>
      <td><span class="badge optional">Optional</span></td>
    </tr>
    <tr>
      <td><code>weibo_url</code></td>
      <td>Weibo profile URL.</td>
      <td><span class="badge optional">Optional</span></td>
    </tr>
  </tbody>
</table>
