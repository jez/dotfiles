-- TODO(jez) Eventually, this should be subsumed by a proper window manager
-- implementation in Hammerspoon...

local fnutils = require("hs.fnutils")
local window = require("hs.window")
local windowfilter = require("hs.window.filter")
local logger = require("hs.logger")
local log = logger.new("wswitcher")
local switcher = { setLogLevel = log.setLogLevel, getLogLevel = log.getLogLevel } -- module

local function show(self, dir)
    local windows = self.wf:getWindows(windowfilter.sortByCreated)

    local nwindows = #windows or 0
    if nwindows == 0 then
        self.log.i("no windows")
        return
    end

    -- If focusedWindow is `nil`, `indexOf` will return `nil`
    -- (because windows always has non-nil values)
    local selected = fnutils.indexOf(windows, window.focusedWindow()) or 1
    -- -1/+1 is to map to 0-indexed and back, for mod
    selected = (selected - 1 + dir) % nwindows + 1

    windows[selected]:focus()
end

function switcher:next()
    return show(self, 1)
end

function switcher:previous()
    return show(self, -1)
end

--- hs.window.switcher.new([windowfilter[, logname, [loglevel]]]) -> hs.window.switcher object
--- Constructor
--- Creates a new switcher instance; it can use a windowfilter to determine which windows to show
---
--- Parameters:
---  * windowfilter - (optional) if omitted or nil, use the default windowfilter; otherwise it must be a windowfilter
---    instance or constructor table
---    must follow the conventions described in `hs.window.switcher.ui`; this parameter allows you to have multiple
---    switcher instances with different behaviour (for example, with and without thumbnails and/or titles)
---    using different hotkeys
---  * logname - (optional) name of the `hs.logger` instance for the new switcher; if omitted, the class logger will be used
---  * loglevel - (optional) log level for the `hs.logger` instance for the new switcher
---
--- Returns:
---  * the new instance
function switcher.new(wf, logname, loglevel)
    local self = setmetatable({}, { __index = switcher })

    self.log = logname and logger.new(logname, loglevel) or log
    self.setLogLevel = self.log.setLogLevel
    self.getLogLevel = self.log.getLogLevel

    if wf == nil then
        self.log.i("new windowswitcher instance, using default windowfilter")
        self.wf = windowfilter.default
    else
        self.log.i("new windowswitcher instance using windowfilter instance")
        self.wf = windowfilter.new(wf)
    end

    return self
end

return switcher
