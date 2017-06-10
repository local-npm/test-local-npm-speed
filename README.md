# test-local-npm-speed

[![Build Status](https://travis-ci.org/local-npm/test-local-npm-speed.svg?branch=master)](https://travis-ci.org/local-npm/test-local-npm-speed)

> Compare the `npm install` times for [local-npm](https://github.com/local-npm/local-npm/) versus regular `npm`, using some popular JavaScript repos.

<!-- TOC depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 -->

- [test-local-npm-speed](#test-local-npm-speed)
- [Summary](#summary)
		- [nolanlawson/tiny-queue](#nolanlawsontiny-queue)
		- [lodash/lodash](#lodashlodash)
		- [substack/node-browserify](#substacknode-browserify)
		- [strongloop/express](#strongloopexpress)
		- [facebook/react](#facebookreact)
		- [gulpjs/gulp](#gulpjsgulp)
		- [pouchdb/pouchdb](#pouchdbpouchdb)
- [Full data](#full-data)
- [nolanlawson/tiny-queue](#nolanlawsontiny-queue)
	- [local-npm](#local-npm)
	- [Regular npm](#regular-npm)
- [lodash/lodash](#lodashlodash)
	- [local-npm](#local-npm)
	- [Regular npm](#regular-npm)
- [substack/node-browserify](#substacknode-browserify)
	- [local-npm](#local-npm)
	- [Regular npm](#regular-npm)
- [strongloop/express](#strongloopexpress)
	- [local-npm](#local-npm)
	- [Regular npm](#regular-npm)
- [facebook/react](#facebookreact)
	- [local-npm](#local-npm)
	- [Regular npm](#regular-npm)
- [gulpjs/gulp](#gulpjsgulp)
	- [local-npm](#local-npm)
	- [Regular npm](#regular-npm)
- [pouchdb/pouchdb](#pouchdbpouchdb)
	- [local-npm](#local-npm)
	- [Regular npm](#regular-npm)
- [Notes](#notes)
- [Reproduce these results](#reproduce-these-results)

<!-- /TOC -->

I started off with a small repo of mine, `nolanlawson/tiny-queue`, then moved on to some popular libraries like `lodash/lodash` and `facebook/react`. In each case, I'm just cloning the code from Github and running `npm install`.

**TLDR:** Regular npm is faster for the first `npm install`, but afterwards `local-npm` is always faster, even after `npm cache clear`. Sometimes it's even 2x or 3x faster (e.g. 1m15.752s vs 3m50.467s to install `facebook/react` the 2nd time). This is kind of the point of `local-npm`: it gets faster the more you run it, because it aggressively caches everything.

# Summary

### nolanlawson/tiny-queue
* 45.69% slower for first `npm install`
* 3.22% faster for second `npm install`
* 16.99% faster after `npm cache clear`
### lodash/lodash
* 34.26% slower for first `npm install`
* 6.78% faster for second `npm install`
* 2.75% slower after `npm cache clear`
### substack/node-browserify
* 33.00% slower for first `npm install`
* 5.64% faster for second `npm install`
* 20.27% slower after `npm cache clear`
### strongloop/express
* 29.44% slower for first `npm install`
* 9.86% faster for second `npm install`
* 15.16% faster after `npm cache clear`
### facebook/react
* 26.71% slower for first `npm install`
* 8.89% slower for second `npm install`
* 2.76% faster after `npm cache clear`
### gulpjs/gulp
* 10.40% slower for first `npm install`
* 6.68% faster for second `npm install`
* 12.54% slower after `npm cache clear`
### pouchdb/pouchdb
* 8.16% slower for first `npm install`
* 6.13% faster for second `npm install`
* 12.62% faster after `npm cache clear`

# Full data

# nolanlawson/tiny-queue
## local-npm
* 1st npm install: 0m2.392s
* 2nd npm install: 0m1.263s
* After cache clean: 0m2.447s
## Regular npm
* 1st npm install: 0m1.299s
* 2nd npm install: 0m1.305s
* After cache clean: 0m2.948s
# lodash/lodash
## local-npm
* 1st npm install: 1m22.140s
* 2nd npm install: 0m48.855s
* After cache clean: 1m19.177s
## Regular npm
* 1st npm install: 0m53.995s
* 2nd npm install: 0m52.407s
* After cache clean: 1m17.000s
# substack/node-browserify
## local-npm
* 1st npm install: 0m41.307s
* 2nd npm install: 0m26.133s
* After cache clean: 0m49.842s
## Regular npm
* 1st npm install: 0m27.677s
* 2nd npm install: 0m27.695s
* After cache clean: 0m39.738s
# strongloop/express
## local-npm
* 1st npm install: 0m19.571s
* 2nd npm install: 0m13.149s
* After cache clean: 0m16.645s
## Regular npm
* 1st npm install: 0m13.810s
* 2nd npm install: 0m14.587s
* After cache clean: 0m19.619s
# facebook/react
## local-npm
* 1st npm install: 2m30.568s
* 2nd npm install: 1m54.844s
* After cache clean: 2m39.366s
## Regular npm
* 1st npm install: 1m50.349s
* 2nd npm install: 1m44.638s
* After cache clean: 2m43.893s
# gulpjs/gulp
## local-npm
* 1st npm install: 0m40.063s
* 2nd npm install: 0m36.125s
* After cache clean: 1m4.591s
## Regular npm
* 1st npm install: 0m35.895s
* 2nd npm install: 0m38.711s
* After cache clean: 0m56.494s
# pouchdb/pouchdb
## local-npm
* 1st npm install: 2m37.697s
* 2nd npm install: 2m2.765s
* After cache clean: 2m40.102s
## Regular npm
* 1st npm install: 2m24.823s
* 2nd npm install: 2m10.778s
* After cache clean: 3m3.219s

# Notes

The test is a little unfair, because my `local-npm` has already downloaded all the metadata, but this is a typical use-case for `local-npm`. (It replicates the npm metadata on first run, which can take a few hours.) I did clear out the tarballs before the test, though.

Also, repos tested later in the test may benefit from a slight boost, if they share any modules with a previous repo. But again, this is a typical use-case for `local-npm` &ndash; the more you use it, the more that common tarballs will be pre-cached.

I find it interesting that `local-npm` is faster even after the second `npm install`, which is when npm's cache is supposed to kick in. This suggests that npm is not caching as aggressively as it could be.

# Reproduce these results

First, `npm install -g local-npm && local-npm`. Then just clone this repo and run `npm test`. The python script can print a summary afterwards.

**Warning:** the test will override your local `~/.npmrc` file! So you may want to do `npmrc -c testing && npmrc testing` beforehand.
