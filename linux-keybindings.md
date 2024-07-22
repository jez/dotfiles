# Setting up Linux keybindings

Go into the keyboard settings, set ~everything to `Disabled` by removing any
default keybindings, except:

- You can leave the "Move, resize, and swap windows" section largely untouched
  except unbind "Adjustment mode" (the other things in that section are only
  keybindings that apply in adjustment mode).

- Navigate applications and windows
  - Set "Launch and switch applications" to `Super + Space`
  - Set "Switch focus to window down" to `Shift + Alt + J`
  - Set "Switch focus to window left" to `Shift + Alt + H`
  - Set "Switch focus to window right" to `Shift + Alt + L`
  - Set "Switch focus to window up" to `Shift + Alt + K`

- Navigation
  - Set "Switch applications" to **only** `Super + Tab`
  - Leave "Switch windows of an application" as `` Super + ` `` / `Super + ~`
  - Set "Move to workspace above" to `Shift + Alt + {`
  - Set "Move to workspace below" to `Shift + Alt + }`
  - Set "Move window one workspace down" to `Shift + Ctrl + Alt + Down`
  - Set "Move window one workspace up" to `Shift + Ctrl + Alt + Up`
  - Set "Move window to workspace 1" to `Shift + Ctrl + Alt + !`
  - Set "Move window to workspace 2" to `Shift + Ctrl + Alt + @`
  - Set "Move window to workspace 3" to `Shift + Ctrl + Alt + #`
  - Set "Move window to workspace 4" to `Shift + Ctrl + Alt + $`

- Screenshots
  - Leave as is

- Windows
  - Set "Close window" to **only** `Super + Q`

- System
  - Set "Show workspaces" to `Ctrl + Up`

Go into Tweaks settings, and set "Keyboard & Mouse > Keyboard > Overview
Shortcut" to "Right Super" which you don't have on your Ergodox.

TODO

- [  ] @jez Japanese input
- [  ] @jez Toggle "all windows are full screen" and then "all windows are tiled"
- [  ] @jez See if you want to bind any of the other "Windows" shortcuts to be
  like Amethyst (rearranging windows within a single workspace)
- [  ] @jez Figure out what to do about Emacs keybindings when editing text.
  - Is there a way to get this to work conditionally?
  - Specifically: GitHub file view mode is a non-editable text file
  - Specifically: Firefox new tab auto-focuses the textbox
  - Mostly a problem with `Ctrl-W` (close window vs delete word backwards) but
    also with `Ctrl-F` and probably others
- [  ] @jez Figure out how to get HEIC thumbnails working on Elementary Files.



