# Where to register yubikey

Disable FIDO2 interface so that you don't get passkeys, only 2fa keys.

```
ykman config usb --disable FIDO2 --force
```

- [x] Google
- [x] GitHub

## SSH keys

- [x] GitHub (@jez)

## Random configs

- [x] ~/stripe
  - [x] especially applications
- [x] ~/.ssh/config
- [x] ~/bin
- [x] ~/stripe/cargo/bin
- [x] ~/.histfile
- [x] ~/sandbox
- [x] ~/.config
- [x] -a ~/

## Browser

- Tabs
- History?

## TODO

- [ ] less keybindings
- [x] fonts in Font Book
- [x] pay-server branches, including stash
- [x] sorbet branches, including stash
- [ ] sorbet compile_commands.json
- [x] GPG keys
- [x] hub tokens
  - [x] remote dev hub tokens
- [x] zoom preferences
- [x] meetingbar
- [x] fast git fetch (<http://go/gitfetch>)
- [x] fast git log with graph (`fastgitlog`)
- [x] Chrome profiles
- [x] GitHub (@jez-stripe)
- [x] log into jez-stripe in profile
- [x] pay-server full git history
- [x] any random ~/.config files
- [x] ~/Desktop on old laptop
- [x] ~/.bazelrc.local in Sorbet
- [x] Pre-replacement checklist
  - <https://confluence.corp.stripe.com/display/HELPDESK/Pre-Replacement+Checklist>
- [x] Post-replacement checklist
  - <https://confluence.corp.stripe.com/pages/viewpage.action?pageId=326689227>
- [x] vault passwords
- [x] Run this in pay-server to get vim-rhubarb to work for Gbrowse:
  ```
  git remote set-url origin git.corp.stripe.com:stripe-internal/pay-server.git
  ```

blurry fonts:
```
defaults -currentHost write -g AppleFontSmoothing -int 0
```
and then restart to take effect



