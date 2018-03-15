---
layout: default
permalink: /contributing/
title: iOS Dev Directory - Contributing
---

# Adding a site to the iOS Dev Directory

Is there something missing from this directory? Here's everything you need to know to get it added.

## Guidelines for Inclusion

Only sites relevant to iOS development or design will be added to this directory. However, if your site is not *purely* about iOS Development or design and includes other topics please try and use categories (if your blog software supports them) to filter it down before submission.

For example if you post mainly about Swift development, occasionally about iOS design and sometimes about other topics, you should do something like this:

* Add a link to your site's development related posts to the "iOS Development Blogs" category.
* Add a link to your site's design related posts to the "iOS Design Blogs" category.
* Leave out the other categories from your site!

If in doubt, submit a pull request using the instructions below and we'll have a conversation about it.

This site currently only contains English language blogs and sites but if there is sufficient interest I'd welcome non English language blogs and would create categories for those.

If you think there's a category missing or want to suggest a bigger change to the site, [open an issue](https://github.com/daveverwer/iOSDevDirectory/issues/new).

## How to Contribute

These simple instructions should be everything you need to get a new site included in the directory:

1. Fork [this repository](https://github.com/daveverwer/iOSDevDirectory) on GitHub.
2. Edit [sites.json](https://github.com/daveverwer/iOSDevDirectory/blob/master/sites.json) and add your site. See below for the details of the JSON format.
3. Submit a pull request.

Once the pull request is accepted and merged, this site will be re-generated and your link will magically appear! Thank you for wanting to contribute.

## Adding your site


Your site should be added as a JSON hash in the correct category. The following keys are valid:

<div class="json-fields">
  <ul>
    <li><code>title</code> &ndash; The title of the blog/site. If it is just a personal blog, use the format "John Appleseed's Blog". This field is required.</li>
    <li><code>author</code> &ndash; A free text string containing the author(s) names. Try to keep this less than 30 characters. This field is required.</li>
    <li><code>site_url</code> &ndash; A valid URL to the web version of the blog/site. This field is required.</li>
    <li><code>feed_url</code> &ndash; A valid URL to the RSS/ATOM feed for the blog/site. This field is required.</li>
    <li><code>twitter_url</code> &ndash; A valid URL to the Twitter account for the blog/site. This field is required.</li>
  </ul>
</div>
