# iOS Dev Directory Website

The website for the [iOS Dev Directory](https://iosdevdirectory.com), a community-maintained list of blogs and sites covering Apple platform and Swift development.

The directory data source lives in a [separate repo](https://github.com/iOSDevDirectory/iOSDevDirectory). This repo is the Jekyll site that displays it.

## Running the site locally

```
bundle install
bundle exec jekyll serve
```

The site will be available at `http://localhost:8080`.

Blog data is pulled from GitHub automatically during the Jekyll build, so there's no need to manually sync the data.

## Contributing

To add or update a site listing, submit a PR to the [data repo](https://github.com/iOSDevDirectory/iOSDevDirectory). If you're interested in helping maintain the site or the data submissions, [get in touch](https://daveverwer.com).
