chrome.runtime.onMessage.addListener (request, sender) ->
  if request.active?
    details =
      if request.active
        path: "icons/rof-on-38x38.png"
      else
        path: "icons/rof-off-38x38.png"
    details.tabId = sender.tab.id
    chrome.browserAction.setIcon details, ->
      console.log chrome.runtime.lastError if chrome.runtime.lastError
  false
