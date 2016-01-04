Test `local-npm` speed
===

This is a test to check the `npm install` times for [local-npm](https://github.com/nolanlawson/local-npm/) compared to normal `npm` against the main registry (https://registry.npmjs.org).

The test was run on a MacBook Air, with node 5.3.0 and npm 3.3.12. I'm on a slow-ish public WiFi at a café in Brooklyn.

I started off with a small repo of mine, `nolanlawson/tiny-queue`, then moved on to some popular libraries like `lodash/lodash` and `facebook/react`. In each case, I'm just cloning the code from Github and running `npm install`.

**TLDR:** Regular npm is faster for the first `npm install`, but afterwards `local-npm` is always faster, even after `npm cache clear`. Sometimes it's even 2x or 3x faster (e.g. 1m15.752s vs 3m50.467s to install `facebook/react` the 2nd time).

Summary
----

### nolanlawson/tiny-queue

* 56.92% slower for first `npm install`
* 5.46% faster for second `npm install`
* 43.15% faster after `npm cache clear`

### lodash/lodash

* 51.04% slower for first `npm install`
* 61.32% faster for second `npm install`
* 85.44% faster after `npm cache clear`

### substack/node-browserify

* 14.43% slower for first `npm install`
* 39.12% faster for second `npm install`
* 90.41% faster after `npm cache clear`

### strongloop/express

* 21.40% faster for first `npm install`
* 81.01% faster for second `npm install`
* 92.20% faster after `npm cache clear`

### facebook/react

* 14.41% faster for first `npm install`
* 67.13% faster for second `npm install`
* 74.65% faster after `npm cache clear`

### gulpjs/gulp

* 75.62% faster for first `npm install`
* 61.89% faster for second `npm install`
* 80.46% faster after `npm cache clear`

### pouchdb/pouchdb

* 6.53% slower for first `npm install`
* 38.34% faster for second `npm install`
* 26.73% faster after `npm cache clear`

Full data
----


### nolanlawson/tiny-queue

#### local-npm

* 1st npm install: 0m8.840s
* 2nd npm install: 0m1.679s
* After cache clean: 0m2.008s

#### Regular npm

* 1st npm install: 0m3.808s
* 2nd npm install: 0m1.776s
* After cache clean: 0m3.532s

### lodash/lodash

#### local-npm

* 1st npm install: 5m49.502s
* 2nd npm install: 0m51.192s
* After cache clean: 0m50.634s

#### Regular npm

* 1st npm install: 2m51.100s
* 2nd npm install: 2m12.354s
* After cache clean: 5m47.880s

### substack/node-browserify

#### local-npm

* 1st npm install: 1m47.306s
* 2nd npm install: 0m23.969s
* After cache clean: 0m22.342s

#### Regular npm

* 1st npm install: 1m31.819s
* 2nd npm install: 0m39.369s
* After cache clean: 3m52.876s

### strongloop/express

#### local-npm

* 1st npm install: 1m17.844s
* 2nd npm install: 0m12.225s
* After cache clean: 0m13.667s

#### Regular npm

* 1st npm install: 1m39.033s
* 2nd npm install: 1m4.360s
* After cache clean: 2m55.139s

### facebook/react

#### local-npm

* 1st npm install: 2m56.140s
* 2nd npm install: 1m15.752s
* After cache clean: 1m24.086s

#### Regular npm

* 1st npm install: 3m25.784s
* 2nd npm install: 3m50.467s
* After cache clean: 5m31.755s

### gulpjs/gulp

#### local-npm

* 1st npm install: 0m51.744s
* 2nd npm install: 0m41.765s
* After cache clean: 0m47.815s

#### Regular npm

* 1st npm install: 3m32.214s
* 2nd npm install: 1m49.591s
* After cache clean: 4m4.641s

### pouchdb/pouchdb

#### local-npm

* 1st npm install: 7m31.151s
* 2nd npm install: 4m7.253s
* After cache clean: 5m2.884s

#### Regular npm

* 1st npm install: 7m1.702s
* 2nd npm install: 6m40.994s
* After cache clean: 6m53.363s

Notes
---

Note that the test is a little unfair, because my `local-npm` has already downloaded all the metadata, but this is a typical use-case for `local-npm`. (It replicates the npm metadata on first run, which can take a few hours.) I did clear out the tarballs before the test, though.

Also, repos tested later in the test may benefit from a slight boost, if they share any modules with a previous repo. But again, this is a typical use-case for `local-npm` &ndash; the idea is that the more you use it, the faster it gets.


Reproduce these results
---

Just clone this repo and run `npm run test`. The python script can print a summary.

**Note:** the test will override your local `~/.npmrc` file! So you may want to do `npmrc -c testing && npmrc testing` beforehand.