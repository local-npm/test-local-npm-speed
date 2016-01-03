#!/usr/bin/env bash

LOCAL_NPM=$(pwd)/node_modules/.bin/local-npm
#REPOS='lodash/lodash substack/node-browserify strongloop/express
#  facebook/react gulpjs/gulp pouchdb/pouchdb'
REPOS='nolanlawson/blob-util'

function timeIt () { { time npm install > /dev/null 2>&1 ; } 2>&1 | grep real | awk '{print $2}' ; }

rm -f results.txt
touch results.txt
npm cache clean

for repo in $REPOS; do

  echo "yo yo yo"

  echo "# $repo" >> results.txt

  git clone --single-branch -b master --depth 1 https://github.com/$repo workspace
  cd workspace

  echo "## local-npm" >> results.txt

  npm set registry http://127.0.0.1:5080
  echo "### First npm install" >> results.txt
  rm -fr node_modules
  timeIt >> results.txt
  echo "### Second npm install" >> results.txt
  rm -fr node_modules
  timeIt >> results.txt
  npm cache clean

  echo "## Regular npm" >> results.txt

  npm set registry https://registry.npmjs.org
  echo "### First npm install" >> results.txt
  rm -fr node_modules
  timeIt >> results.txt
  echo "### Second npm install" >> results.txt
  rm -fr node_modules
  timeIt >> results.txt
  npm cache clean

  cd ..

  # clean up
  rm -fr workspace

done

cat results.txt