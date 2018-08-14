#!/bin/bash
set -x

# skip if build is triggered by pull request
if [ $TRAVIS_PULL_REQUEST == "true" ]; then
  echo "this is PR, exiting"
  exit 0
fi

# enable error reporting to the console
set -e

# cleanup "_site"
rm -rf _site
mkdir _site

# clone remote repo to "_site"
git clone https://${GH_TOKEN}@github.com/linuxdevspace/blog.git --branch gh-pages _site

#  make sure all dependencies in the Gemfile are available 
bundle install --deployment

# update all gems to the latest 
if [ $BUNDLE_UPDATE == "true" ]; then
  git add Gemfile.lock
  bundle update
  git add Gemfile.lock
fi

# build with Jekyll into "_site"
bundle exec jekyll build

# copy CNAME
cp CNAME _site

# push
cd _site
git config user.email "gayan@linuxdeveloper.space"
git config user.name "Gayan Weerakutti"
git add --all
git commit -a -m "Travis #$TRAVIS_BUILD_NUMBER"
git push --force origin gh-pages

set +x
