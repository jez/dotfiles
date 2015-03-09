# jez does dotfiles

[![xkcd: Automation](http://imgs.xkcd.com/comics/automation.png)](http://xkcd.com/1319/)

## Installation

Unless you're sitting next to me, I wouldn't really recommend a complete
installation of these dotfiles. They might get to that polished, pristine state
at some point, but right now they're not there.

They're getting closer though.

If you insist, you can see the steps that I run through when setting up a new
[OS X laptop](osx-setup.sh) or [server](ubuntu-setup.sh). They read like
scripts, but __please don't run them like scripts__. I've never needed them to
be robust enough to be run attended; I always just copy and paste each command
one at a time in case something has changed between the last time I set up a
device and now.

I suppose for those that _just want the dotfiles_ getting set up is as easy as

```bash
git clone --recursive https://github.com/jez/dotfiles ~/.dotfiles
cd ~/.dotfiles
RCRC="./rcrc" rcup
```

__However__, my dotfiles make a heavy-handed assumption that you're using zsh +
OS X + Homebrew + iTerm2 most of the time, which is agreeable for me but maybe
unagreeable for you. This is why I wouldn't recommend just cloning the repo and
running with it. If you're looking for a solution like that, there are plenty of
excellent resources online at <https://dotfiles.github.io>.

## Organization

The biggest changes in this rewrite of my dotfiles is the new organization. It
uses [rcm][rcm] heavily to help organize per-host configuration settings, as
well as modularity to make swapping code in and out easier under when using rcm.
For example, most of my `zshrc` is actually chopped up into files hidden within
the `util/` directory.

## Credits

I've rewritten my dotfiles many times (hence the above comic XD), and each time
I've been influenced by someone new. These people include [bezi][bezi],
[tomshen][tomshen], and [holman][holman].

## LICENSE

MIT License. See LICENSE.

[bezi]: https://github.com/bezi
[tomshen]: https://github.com/tomshen
[holman]: https://github.com/holman
[rcm]: https://github.com/thoughtbot/rcm
