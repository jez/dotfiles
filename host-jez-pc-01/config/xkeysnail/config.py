# -*- coding: utf-8 -*-

import re
from xkeysnail.transform import *

# xkeysnail syntax reference:
# https://github.com/mooz/xkeysnail#define_keymapcondition-mappings-name
#
# For every change in this file you will need to run
#
#     systemctl --user restart xkeysnail
#
# ... or to be really safe:
#
#     systemctl --user stop xkeysnail
#     systemctl --user start xkeysnail

terminals = [
    "alacritty"
]

term_str = "^({})$".format("|".join(terminals))
term_regex = re.compile(term_str, re.IGNORECASE)

# ----- Swap Super/Command and Control everywhere except terminals ----- {{{

# These modmaps ("modifier maps") trigger before keymaps.
#
# Which means that in all the `define_keymap` stanzas below, use Control for
# shortcuts that involve pressing Command on the keyboard (except in any
# terminal-related keymap stanzas, where this swapping won't have happened).
define_conditional_modmap(lambda wm_class: wm_class.casefold() not in terminals, {
    # Here and here only, META means SUPER... thanks xkeysnail
    Key.LEFT_META: Key.RIGHT_CTRL,
    Key.LEFT_CTRL: Key.LEFT_META,
    Key.RIGHT_META: Key.RIGHT_CTRL,
    Key.RIGHT_CTRL: Key.RIGHT_META,
})

# }}}

# ----- File Managers ----- {{{

file_managers = [
    "io.elementary.files",
    "org.gnome.nautilus",
]
file_managers_str = "|".join(str('^'+x+'$') for x in file_managers)
file_managers_regex = re.compile(file_managers_str, re.IGNORECASE)

# Keybindings overrides for elementary OS Files (Pantheon)
# (overrides some bindings from general file manager code block below)
define_keymap(re.compile("^io.elementary.files$", re.IGNORECASE), {
    K("Ctrl-Super-O"):            K("Shift-Enter"),     # Open folder in new tab
    K("Ctrl-Comma"):              None,                 # Disable preferences shortcut since none available
}, "Overrides for Pantheon - Finder Mods")

define_keymap(file_managers_regex, {
    # -------- Show Properties (Get Info) | Open Settings/Preferences | Show/Hide hidden files -------
    K("Ctrl-I"):                  K("Alt-Enter"),       # File properties dialog (Get Info)
    K("Ctrl-comma"):              [K("Alt-E"),K("N")],  # Open preferences dialog
    K("Ctrl-Shift-Dot"):          K("Ctrl-H"),          # Show/hide hidden files ("dot" files)

    # ------- Navigation -------
    K("Ctrl-Left_Brace"):         K("Alt-Left"),        # Go Back
    K("Ctrl-Right_Brace"):        K("Alt-Right"),       # Go Forward
    K("Ctrl-Left"):               K("Alt-Left"),        # Go Back
    K("Ctrl-Right"):              K("Alt-Right"),       # Go Forward
    K("Ctrl-Up"):                 K("Alt-Up"),          # Go Up dir
    K("Ctrl-Down"):               K("Enter"),           # Go Down dir (open folder/file) [universal]
    K("Ctrl-Shift-Left_Brace"):   K("Ctrl-Page_Up"),    # Go to prior tab
    K("Ctrl-Shift-Right_Brace"):  K("Ctrl-Page_Down"),  # Go to next tab
    K("Ctrl-Shift-Left"):         K("Ctrl-Page_Up"),    # Go to prior tab
    K("Ctrl-Shift-Right"):        K("Ctrl-Page_Down"),  # Go to next tab

    # ------- Open in New Window | Move to Trash | Duplicate file/folder --------
    K("Ctrl-Super-O"):            K("Ctrl-Shift-O"),    # Open in new window (or possibly tab) [not universal]
    K("Ctrl-Backspace"):          K("Delete"),          # Move to Trash (delete)
    K("Ctrl-D"):                  [K("Ctrl-C"),K("Ctrl-V")],# Duplicate file/folder (Copy, then Paste)

    # ------- Renaming files with the Enter key
    # Use Super+Enter to escape or activate text fields such as "[F]ind" and "[L]ocation" fields.
    K("Enter"):                   K("F2"),              # Rename with Enter key
    K("Ctrl-Enter"):              K("Enter"),           # Remap alternative "Enter" key for text fields

    # ------- Open file -------
    K("Ctrl-O"):                  K("Enter"),           # Open file with default program
}, "General File Managers - Finder Mods")
# }}}

# ----- Web browsers ----- {{{

browsers = [
    "firefox",
]

browsers_str = "|".join(str('^'+x+'$') for x in browsers)
browsers_regex = re.compile(browsers_str, re.IGNORECASE)

define_keymap(re.compile("^firefox$", re.IGNORECASE), {
    # Open preferences in new tab
    K("Ctrl-comma"): [
        K("Ctrl-T"),K("a"),K("b"),K("o"),K("u"),K("t"),
        K("Shift-SEMICOLON"),K("p"),K("r"),K("e"),K("f"),
        K("e"),K("r"),K("e"),K("n"),K("c"),K("e"),K("s"),K("Enter")
    ],
}, "Firefox")

define_keymap(browsers_regex, {
    K("Ctrl-Alt-I"):       K("Ctrl-Shift-I"),   # Inspector
    K("Ctrl-Alt-J"):       K("Ctrl-Shift-J"),   # JavaScript console
    K("Ctrl-Alt-U"):       K("Ctrl-U"),         # View source

    K("Ctrl-Key_1"):       K("Alt-Key_1"),      # Jump to Tab #1-#8
    K("Ctrl-Key_2"):       K("Alt-Key_2"),
    K("Ctrl-Key_3"):       K("Alt-Key_3"),
    K("Ctrl-Key_4"):       K("Alt-Key_4"),
    K("Ctrl-Key_5"):       K("Alt-Key_5"),
    K("Ctrl-Key_6"):       K("Alt-Key_6"),
    K("Ctrl-Key_7"):       K("Alt-Key_7"),
    K("Ctrl-Key_8"):       K("Alt-Key_8"),
    K("Ctrl-Key_9"):       K("Alt-Key_9"),      # Jump to last tab

    K("Ctrl-Alt-Left"):    K("Ctrl-Page_Up"),   # Go to prior tab
    K("Ctrl-Alt-Right"):   K("Ctrl-Page_Down"), # Go to next tab

}, "General Web Browsers")

# }}}

# ----- Everything but terminals ----- {{{

define_keymap(lambda wm_class: wm_class.casefold() not in terminals, {
    # ------- To coordinate with system keyboard shortcuts -------
    # I have very few manual changes in the system keyboard shortcuts (most are
    # disabled) but the ones that are on need to be told explicitly to go against
    # the modmap from above.
    K("Ctrl-Tab"):               K("Super-Tab"),            # Navigation > Switch applications
    K("Ctrl-Grave"):             K("Super-Grave"),          # Navigation > Switch windows of an application
    K("Ctrl-Shift-Grave"):       K("Super-Shift-Grave"),    # Navigation > Switch windows of an application
    K("Ctrl-Space"):             K("Super-Space"),          # Navigate applications and windows > Launch
                                                            #     and switch applications
    K("Ctrl-Q"):                 K("Super-Q"),              # Windows > Close window
    K("Ctrl-H"):                 K("Super-H"),              # Windows > Close window
    K("Super-Up"):               K("Ctrl-Up"),              # System > Show workspaces
    # Amethyst mod2 keyboard shortcuts
    K("Super-Shift-Alt-Down"):   K("Ctrl-Shift-Alt-Down"),  # Navigation > Move window one workspace down
    K("Super-Shift-Alt-Up"):     K("Ctrl-Shift-Alt-Up"),    # Navigation > Move window one workspace up
    K("Super-Shift-Alt-Key_1"):  K("Ctrl-Shift-Alt-Key_1"), # Navigation > Move window to workspace 1
    K("Super-Shift-Alt-Key_2"):  K("Ctrl-Shift-Alt-Key_2"), # Navigation > Move window to workspace 2
    K("Super-Shift-Alt-Key_3"):  K("Ctrl-Shift-Alt-Key_3"), # Navigation > Move window to workspace 3
    K("Super-Shift-Alt-Key_4"):  K("Ctrl-Shift-Alt-Key_4"), # Navigation > Move window to workspace 4

    # ------- Screenshots -------
    # This one is non-standard; in macOS it would be Shift + Cmd + 3 and then Space
    K("Ctrl-Shift-Key_2"):       K("Alt-Print"),            # Screenshots > Take a screenshot of a window
    K("Ctrl-Shift-Key_3"):       K("Shift-Print"),          # Screenshots > Take a screenshot
    K("Ctrl-Shift-Key_4"):       K("Print"),                # Screenshots > Take a screenshot interactively
    K("Ctrl-Shift-Key_5"):       K("Shift-Ctrl-Alt-R"),     # Screenshots > Record a screencast interactively

    # ------- Wordwise -------
    K("Ctrl-Left"):         K("Home"),                      # Beginning of Line
    K("Ctrl-Right"):        K("End"),                       # End of Line
    K("Ctrl-Shift-Left"):   K("Shift-Home"),                # Select all to Beginning of Line
    K("Ctrl-Shift-Right"):  K("Shift-End"),                 # Select all to End of Line
    K("Ctrl-Up"):           K("Ctrl-Home"),                 # Beginning of File
    K("Ctrl-Down"):         K("Ctrl-End"),                  # End of File
    K("Ctrl-Shift-Up"):     K("Ctrl-Shift-Home"),           # Select all to Beginning of File
    K("Ctrl-Shift-Down"):   K("Ctrl-Shift-End"),            # Select all to End of File
    K("Alt-Backspace"):     K("Ctrl-Backspace"),            # Delete Word Left of Cursor
    # ... supposedly Ctrl-Shift-Backspace is supposed to work here but it doesn't for me??
    K("Ctrl-Backspace"):    [K("Shift-Home"), K("Backspace")],  # Delete Line Left of Cursor
    # ... kinto.sh puts these in the "not VS Code" section., might have to do that eventually
    K("Alt-Left"):          K("Ctrl-Left"),                 # Left of Word
    K("Alt-Shift-Left"):    K("Ctrl-Shift-Left"),           # Select Left of Word
    K("Alt-Right"):         K("Ctrl-Right"),                # Right of Word
    K("Alt-Shift-Right"):   K("Ctrl-Shift-Right"),          # Select Right of Word

}, "Everything but terminals")

# }}}

# ----- Terminals ----- {{{

# Not needed yet, here just in case
# define_keymap(lambda wm_class: wm_class.casefold() in terminals, {
# }, "Terminals")

# }}}

# ----- VS Code ----- {{{
# TODO(jez) VS Code
# }}}

# vim:fdm=marker
