#!/usr/bin/env bash

REPOS='nolanlawson/tiny-queue lodash/lodash substack/node-browserify strongloop/express facebook/react gulpjs/gulp pouchdb/pouchdb'
#REPOS='nolanlawson/tiny-queue'

RESULTS_FILE=$(pwd)/results.md

function timeIt () { { time npm install > /dev/null 2>&1 ; } 2>&1 | grep real | awk '{print $2}' ; }

rm -fr $RESULTS_FILE workspace
touch $RESULTS_FILE
npm cache clean

for repo in $REPOS; do

  echo "# $repo" >> $RESULTS_FILE

  git clone --single-branch -b master --depth 1 https://github.com/$repo workspace
  cd workspace

  echo "## local-npm" >> $RESULTS_FILE

  npm set registry http://127.0.0.1:5080
  rm -fr node_modules
  echo "* 1st npm install: $(timeIt)" >> $RESULTS_FILE
  rm -fr node_modules
  echo "* 2nd npm install: $(timeIt)" >> $RESULTS_FILE
  rm -fr node_modules
  npm cache clean
  echo "* After cache clean: $(timeIt)" >> $RESULTS_FILE

  echo "## Regular npm" >> $RESULTS_FILE

  npm set registry https://registry.npmjs.org
  rm -fr node_modules
  echo "* 1st npm install: $(timeIt)" >> $RESULTS_FILE
  rm -fr node_modules
  echo "* 2nd npm install: $(timeIt)" >> $RESULTS_FILE
  rm -fr node_modules
  npm cache clean
  echo "* After cache clean: $(timeIt)" >> $RESULTS_FILE

  cd ..

  # clean up
  rm -fr workspace

done

cat $RESULTS_FILE