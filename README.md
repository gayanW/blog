To use a locally stored Ruby Gem
--
```
bundle config local.GEM_NAME /path/to/local/repository
```
**Example**
```
$ bundle config jekyll-theme-linuxdev
$ bundle config jekyll-theme-linuxdev /absolute/path/to/jekyll-theme-linuxdev
```
The configuaration will be written into `~/.bundle/config`.

Build locally
--

To run the site locally,

    bundle exec jekyll serve

Deploy
--

Site gets auto deployed when a commit is pushed to the master branch. Or we could deploy manually by triggering a build from Travis website.
