
{incUrlSeq} = require "../lib/livecss"


describe "incUrlSeq increases the id in the url", ->
  url =  "/foo/bar.js"

  it "adds id in to url", ->
    expect(incUrlSeq url).toBe "/foo/bar--1.js"

  it "increases existing id", ->
    url2 = incUrlSeq url
    expect(incUrlSeq url2).toBe "/foo/bar--2.js"
