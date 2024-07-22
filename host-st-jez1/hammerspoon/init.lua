require("hs.ipc")

-- Hyper + W to remove the current macOS space
hyper = {"cmd", "alt", "ctrl", "shift"}
hs.hotkey.bind(hyper, "W", function()
  currentSpace = hs.spaces.activeSpaceOnScreen('Main')
  -- Main is the one with the currently active window.
  allSpaces = hs.spaces.allSpaces()[hs.screen.mainScreen():getUUID()]
  currentSpaceIdx = 0
  for idx, spaceID in ipairs(allSpaces) do
    if spaceID == currentSpace then
      currentSpaceIdx = idx
      break
    end
  end
  if currentSpaceIdx <= 1 then
    return
  end
  newSpace = allSpaces[currentSpaceIdx - 1]
  hs.spaces.gotoSpace(newSpace)
  hs.timer.doAfter(0.5, function()
    hs.spaces.removeSpace(currentSpace)
  end)
end)
