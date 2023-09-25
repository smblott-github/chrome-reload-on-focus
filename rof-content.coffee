
active = false

chrome.storage.sync.get "regexes", (items) ->
  unless items.regexes
    chrome.storage.sync.set {regexes: ["file://.*"]}, ->

window.addEventListener "focus", (event) ->
  location.reload true if event.target == window and active

init = ->
  chrome.storage.sync.get "regexes", (items) ->
    active = false
    loc = location.toString()
    for regex in items.regexes ? []
      if new RegExp(regex).test loc
        active = true
        break

chrome.storage.onChanged.addListener init
init()
