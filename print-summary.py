#!/usr/bin/env python
import re

s = open('results.md', 'r').read()
times = re.compile('#.?(\S+).*?local-npm.*?(\d+m.*?s).*?(\d+m.*?s).*?(\d+m.*?s).*?Regular npm.*?(\d+m.*?s).*?(\d+m.*?s).*?(\d+m.*?s)', re.DOTALL).findall(s)

def diffIt(first, second):
  first = re.findall('([\d\.]+)m([\d\.]+)s', first)[0]
  second = re.findall('([\d\.]+)m([\d\.]+)s', second)[0]
  first = (float(first[0]) * 60) + float(first[1])
  second = (float(second[0]) * 60) + float(second[1])
  if first < second:
    return '%.2f%% faster' % (100 * ((second - first) * 1.0 / second))
  else:
    return '%.2f%% slower' % (100 * ((first - second) * 1.0 / first))

for time in times:
  print "###", time[0]
  print "*", diffIt(time[1], time[4]), "for first `npm install`"
  print "*", diffIt(time[2], time[5]), "for second `npm install`"
  print "*", diffIt(time[3], time[6]), "after `npm cache clear`"
