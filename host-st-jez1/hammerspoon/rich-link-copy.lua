-- Originally from https://github.com/dbalatero/dotfiles/blob/main/hammerspoon/rich-link-copy.lua
-- Modified to produce Markdown instead of rich text

-- Copies a Markdown link to your currently visible Chrome browser tab
--
-- Link is basically formatted as:
--
--    [Page title](http://the.url.com)
function getRichLinkToCurrentChromeTab()
  local application = hs.application.frontmostApplication()

  -- Only copy from Chrome
  if application:bundleID() ~= "com.google.Chrome" then
    return
  end

  -- Grab the <title> from the page.
  local script = [[
    tell application "Google Chrome"
      get title of active tab of first window
    end tell
  ]]

  local _, title = hs.osascript.applescript(script)

  -- Remove trailing garbage from window title for a better looking link.
  local removePatterns = {
    " – Dropbox Paper.*",
    "- - Google Chrome.*",
    " %- Google Docs",
    " %- Google Sheets",
    " %- Google Drive",
    " %- Jira",
    " – Figma",
    " | Trailhead",
    -- Notion's "(9+) " comment indicator
    "%(%d+%+*%) ",
  }

  for _, pattern in ipairs(removePatterns) do
    title = string.gsub(title, pattern, "")
  end

  -- Get the current URL from the address bar.
  script = [[
    tell application "Google Chrome"
      get URL of active tab of first window
    end tell
  ]]

  local _, url = hs.osascript.applescript(script)

  local markdown =  '['.. title .. '](' .. url .. ')'

  -- Add fun emoji to the link depending on the source.
  -- 99 times 100 I'm pasting this to Slack.
  local emojiPatterns = {
    ["confluence.corp.stripe.com"] = ":confluence:",
    ["docs.google.com/document"] = ":google-docs:",
    ["docs.google.com/spreadsheets"] = ":google-sheets:",
    ["figma.com"] = ":figma-:",
    ["github.com"] = ":github:",
    ["git.corp.stripe.com"] = ":github:",
    ["paper.dropbox.com"] = ":paper:",
    ["whimsical.com"] = ":whimsical:",
    ["groups.google.com"] = ":e-mail:",
    ["notion.so"] = ":notion:",
    ["linear.app"] = ":linear:",
    ["trailhead.corp.stripe.com"] = ":trailhead-icon:",
  }

  for pattern, emoji in pairs(emojiPatterns) do
    if url:find(pattern) then
      markdown = emoji .. " " .. markdown
      break
    end
  end

  -- Insert the link into the clipboard
  hs.pasteboard.writeObjects(markdown)

  hs.alert('Copied link to "' .. title .. '"')
end
