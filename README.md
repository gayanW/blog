[![Build Status](https://travis-ci.org/gayanW/blog.svg?branch=master)](https://travis-ci.org/gayanW/blog)

To use a locally stored Ruby Gem
--
```
bundle config local.GEM_NAME /path/to/local/repository
```
**Example**
```
$ bundle config local.jekyll-theme-linuxdev /absolute/path/to/jekyll-theme-linuxdev
```
The configuaration will be written into `~/.bundle/config`.

To disable the local override: 

```
bundle config --delete local.GEM_NAME
```

Build locally
--

Build with the ruby version used by [GitHub Pages](https://pages.github.com/versions/)

    rbenv install 2.7.4
    rbenv local 2.7.4
    bundle install

However, on Mac M1, it require us to use a slightly newer version of ruby.

    rbenv install 2.7.8
    rbenv local 2.7.8
    bundle install

To run the site locally,

    bundle exec jekyll serve

Find the official instructions [here](https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/testing-your-github-pages-site-locally-with-jekyll).

Deploy
--

Site gets auto deployed when a commit is pushed to the master branch. Or we could deploy manually by triggering a build from Travis website.

Theme
--

When change is made to jekyll-theme-linuxdev repository, do a `bundle install`, or update the revision value in Gemfile.lock manually.

References
----------

 - [GitHub pages dependency versions](https://pages.github.com/versions/)
