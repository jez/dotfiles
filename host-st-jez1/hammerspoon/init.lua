require("hs.ipc")

-- Function to open a new iTerm2 window and run a command
function openITermAndRunCommand(command)
  local iterm = hs.application.get("iTerm")
  if not iterm then
    hs.application.launchOrFocus("iTerm")
    iterm = hs.application.get("iTerm")
  end

  -- Ensure iTerm is running
  if not iterm then
    hs.alert.show("Failed to launch iTerm")
    return
  end

  -- Create a new window
  if not iterm:selectMenuItem({"Shell", "New Window"}) then
    hs.alert.show("Failed to create new iTerm window")
    return
  end

  -- Wait a bit for the window to be ready
  hs.timer.usleep(200000)

  -- Type the command and press return
  hs.eventtap.keyStrokes(command)
  hs.timer.usleep(50000)
  hs.eventtap.keyStroke({}, "return")
end

-- Function to open a new Chrome window with a specific URL
function openChromeWithURL(url)
  local chrome = hs.application.get("Google Chrome")
  if not chrome then
    hs.application.launchOrFocus("Google Chrome")
    chrome = hs.application.get("Google Chrome")
  end

  -- Ensure Chrome is running
  if not chrome then
    hs.alert.show("Failed to launch Google Chrome")
    return
  end

  -- Create a new window
  if not chrome:selectMenuItem({"File", "New Window"}) then
    hs.alert.show("Failed to create new Chrome window")
    return
  end

  -- Wait a bit for the window to be ready
  hs.timer.usleep(200000)

  -- Open the URL
  hs.eventtap.keyStrokes(url)
  hs.timer.usleep(50000)
  hs.eventtap.keyStroke({}, "return")
end

function findIndexDifference(list, left, right)
  local leftIdx, rightIdx

  for idx, cur in ipairs(list) do
    if cur == left then
      leftIdx = idx
    elseif cur == right then
      rightIdx = idx
    end

    if leftIdx and rightIdx then
      return rightIdx - leftIdx
    end
  end

  return nil
end

hyper = {"cmd", "alt", "ctrl", "shift"}

-- -- Hyper + W to remove the current macOS space
-- hs.hotkey.bind(hyper, "W", function()
--   currentSpace = hs.spaces.activeSpaceOnScreen('Main')
--   -- Main is the one with the currently active window.
--   allSpaces = hs.spaces.allSpaces()[hs.screen.mainScreen():getUUID()]
--   currentSpaceIdx = 0
--   for idx, spaceID in ipairs(allSpaces) do
--     if spaceID == currentSpace then
--       currentSpaceIdx = idx
--       break
--     end
--   end
--   if currentSpaceIdx <= 1 then
--     return
--   end
--   newSpace = allSpaces[currentSpaceIdx - 1]
--   hs.spaces.gotoSpace(newSpace)
--   hs.timer.doAfter(0.5, function()
--     hs.spaces.removeSpace(currentSpace)
--   end)
-- end)

-- Hyper + C to compose a new blog post
hs.hotkey.bind(hyper, "C", function()
  -- make a new space
  local window = hs.window.focusedWindow()
  local screen = window:screen()
  hs.spaces.addSpaceToScreen(screen, False)

  -- Go to that new space
  local allSpaces = hs.spaces.allSpaces()
  local spacesOnScreen = allSpaces[screen:getUUID()]
  local newSpace = spacesOnScreen[#(spacesOnScreen)]
  local moveLeftNTimes = findIndexDifference(spacesOnScreen, hs.spaces.activeSpaceOnScreen(), newSpace)
  while moveLeftNTimes > 0 do
    -- Tell macOS to move one space left
    hs.eventtap.keyStroke({"alt", "shift"}, "]")
    moveLeftNTimes = moveLeftNTimes - 1
  end
  -- Have to wait a long time because macOS animations are slow
  hs.timer.usleep(1000000)

  openChromeWithURL("http://localhost:4000/#all-posts")
  -- Open iTerm second so that it's focused at the end
  openITermAndRunCommand("mux-write")
  -- Tell Amythyst to swap the windows
  hs.eventtap.keyStroke({"alt", "shift"}, "return")
  -- Tell Amethyst to make iTerm bigger and Chrome smaller
  hs.eventtap.keyStroke({"alt", "shift"}, "l")
end)
