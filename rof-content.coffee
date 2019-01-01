
active = false
init = (callback) ->
  chrome.storage.sync.get "regexes", (items) ->
    active = false
    loc = location.toString()
    for regex in items.regexes ? []
      if new RegExp(regex).test loc
        active = true
        break
    callback?()

chrome.storage.onChanged.addListener init

chrome.storage.sync.get "regexes", (items) ->
  unless items.regexes
    chrome.storage.sync.set {regexes: ["file://.*"]}, ->

init ->
  window.addEventListener "focus", (event) ->
    if active and event.target == window
      location.reload()
