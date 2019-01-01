
documentReady = do ->
  [isReady, callbacks] = [document.readyState != "loading", []]
  unless isReady
    window.addEventListener "DOMContentLoaded", onDOMContentLoaded = ->
      window.removeEventListener "DOMContentLoaded", onDOMContentLoaded
      isReady = true
      callback() for callback in callbacks
      callbacks = null

  (callback) -> if isReady then callback() else callbacks.push callback

chrome.storage.sync.get "regexes", (items) ->
  items.regexes ?= ["file://.*"]
  documentReady ->
    regexesElement = document.getElementById "regexes"
    previousValue = regexesElement.value = items.regexes.join "\n"

    regexesElement.addEventListener "blur", ->
      newValue = regexesElement.value.trim().split(/\s+/g)
      if newValue.join("\n") != previousValue
        console.log newValue
        previousValue = newValue.join("\n")
        chrome.storage.sync.set {regexes: newValue}, ->
