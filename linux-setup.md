# Notes on building a Linux PC from parts

In August 2019 I started building a PC.

## Build

This turned out to be not that hard.

- Here was my parts list: <https://pcpartpicker.com/list/gbwqYT>
- I was able to get a used graphics card from a friend, which was nice because
  it meant it was cheap.
- I followed this video when putting things together:
  - <https://www.youtube.com/watch?v=i5jFXl0GZJo>
- Getting the fan mounted was really annoying (the lever was hard to flip to
  secure it in place) and I wish I had looked up a video for my particular fan
  before trying it.
- I was worried about BIOS version incompatibilities with the B450 Tomahawk
  motherboard and the Ryzen 7 3700X (having to upgrade the BIOS before the CPU
  could be used), but...
  1. The version it came with out of the box was already updated.
  2. Booting into the BIOS and using the BIOS flashback to upgrade the BIOS
     version is super easy.

## Installing Ubuntu

- I followed this guide to make a bootable USB drive from the command line:
  - <https://apple.stackexchange.com/questions/179781/how-to-create-a-bootable-ubuntu-usb-stick-using-os-x-10-10-2>
  - (my USB drive was already formatted MS-DOS FAT32)
- I could get it to boot into from the UEFI USB boot entry, but when I clicked
  "Install Ubuntu" it would always display "Couldn't get UEFI db list" and then
  the monitor would loop on and off.
  - The fix for this was to click `e` to edit the "Install Ubuntu" kernel
    command to add the `nomodeset` option
  - I learned about the `nomodeset` option from this page
    - <https://ubuntuforums.org/showthread.php?t=1613132>
    - "The newest kernels have moved the video mode setting into the kernel. So
      all the programming of the hardware specific clock rates and registers on
      the video card happen in the kernel rather than in the X driver when the X
      server starts.. This makes it possible to have high resolution nice
      looking splash (boot) screens and flicker free transitions from boot
      splash to login screen. Unfortunately, on some cards this doesnt work
      properly and you end up with a black screen. Adding the nomodeset
      parameter instructs the kernel to not load video drivers and use BIOS
      modes instead until X is loaded."
  - After the installation finished, to make sure that the `nomodeset` option
    applied to the actual install not just the boot USB, I used the boot USB to
    mount the OS I just installed and edit the grub config file directly:
      - <https://askubuntu.com/a/941322>


## Installing Pop OS

- Went here to get an ISO:
  - <https://system76.com/pop>
  - Picked the Nvidia one
- Used Etcher to create the bootable USB
- Booted in and installed with no problems

## Setup

- Nvidia Drivers
  - Used this page to figure out which version to download:
    - <https://www.nvidia.com/Download/index.aspx>
    - But then used `apt` to install it:
      - `sudo apt install nvidia-driver-430`
- Homebrew
  - `sudo apt install curl`
  - <https://docs.brew.sh/Homebrew-on-Linux>
  - `sudo apt install build-essential`
  - Followed instructions on to edit `~/.profile`
  - Followed instructions to source shellenv config
- Devel
  - `brew install gcc`
  - `brew install rbenv`
  - `brew install vim`
  - `brew install git`
- Sorbet
  - `rbenv install 2.4.3`
  - Set up same crazy symlink business that Stripe does
    - `cd ~/.rbenv/versions && ln -s 2.4.3 2.4 && cd -`
  - `export PATH="$HOME/.rbenv/bin:$PATH"`
  - `eval "$(rbenv init -)"`
  - `rbenv rehash`
  - `sudo apt install ruby`
- Window Managers
  - tried cinnamon
    - `sudo apt-add-repository ppa:embrosyn/cinnamon`
    - `sudo apt update && sudo apt intall cinnamon`
  - tried `bspwm`
    - `sudo apt install bspwm`
    - <https://github.com/windelicato/dotfiles/wiki/bspwm-for-dummies>
- Terminal Emulators
  - tried alacritty
    - `wget <github releases amd64.deb>`
    - `sudo apt install ./Alacritty*.deb`
- Fractional scaling in Gnome
  - `gsettings set org.gnome.mutter experimental-features "['x11-randr-fractional-scaling']"`
  - Gnome Settings > Display > 150%
- Keyboard shortcuts
  - Gnome settings
  - `dconf dump / > full-backup`
  - `sudo apt install xautomation`
- Spotify
  - Installed through store
  - `sudo sed -i -e 's/^Exec=spotify/\0 --force-device-scale-factor=2/' /usr/share/applications/spotify.desktop`
- Dropbox
  - Download from: <https://www.dropbox.com/install?os=linux>
  - `sudo apt install` the deb
  - Follow these instructions to put the Dropbox icon in the tray:
    - <https://pop.system76.com/docs/status-icons/>
    - `sudo apt install gnome-shell-extension-appindicator`
    - `gnome-shell-extension-prefs`
  - Bump the max_user_watches to a super high number.
    - <https://web.archive.org/web/20161106193425/http://blog.sorah.jp/2012/01/24/inotify-limitation>
- GitHub setup
  - Generated and added a new SSH key to GitHub
    - <https://help.github.com/en/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent>
- TERM problems
  - tmux is installed via brew, which links against it's own ncurses
  - less (and other programs) are installed outside of brew, and use a different
    version, so sometimes they'll say that the TERM is not fully funcitonal
- Spotify local files:
  - Go into settings
  - Point local files at ~/Dropbox/Music/Spotify
  - Also, probably need to do this to get local files to play:
    - <https://github.com/olejon/spotcommander/wiki/LocalFiles>

## TODO

- Dotfiles / config
  - Grep for TODO(jez) linux
  - Double check bash_profile stuff
  - Fix itpt script
    - Make it work with `nvr '+set bg=light'`

- Try out tiling window manager
- Faster scroll speed
- CPU temp monitoring (waiting on kernel patch)
- Figure out internet splitting
- Make keybindings more like macOS
  - Swap command and control?

- Sorbet
  - Figure out why our bazel setup required a system version of Ruby (from apt)
