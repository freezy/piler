
fs = require "fs"

express = require 'express'
{addCodeSharingTo} = require "express-share"


app = express.createServer()
addCodeSharingTo app






app.configure ->
  app.set 'views', __dirname + '/views'
  app.set "home", "/Foo"
  app.use express.bodyParser()
  app.use express.compiler enable:  ["coffeescript", "less"], src: __dirname + '/public'
  app.use express.static __dirname + '/public'


app.share basic_boolean: true

app.share basic_function: ->
  "cool"

app.share nested:
  first:
    second_a: "a"
    second_b: "b"


MyClass = (arg) ->
  this.arg = arg
MyClass.prototype.foo = ->
  console.log 2345

obj = new MyClass("secret")
app.share 
  obj: obj
  MyClass: MyClass


app.share /^\/subpage.*/, ns_shared_on_subpage: true

app.exec /^\/subpage.*/, ->
  window.NS_EXEC_ON_SUBPAGE = true


app.exec ->
  window.GLOBAL_VAR = true


app.shareFs "fsscript.js"

app.shareFs /^\/subpage.*/, "fsnsscript.js"


app.get "/", (req, res) ->
  res.share test_res_basic_share: true
  res.exec ->
    window.GLOBAL_RES_EXEC = true

  res.render 'index.jade',
    title: "Testing"
    contentText: "content tekit"


app.get "/subpage", (req, res) ->
  res.share sub_page_res: true
  res.render 'index.jade',
    title: "Testing subpage"
    contentText: "content tekit"

app.get "/noresshare", (req, res) ->
  res.render 'index.jade',
    title: "No res.share is used"

app.listen 1234

