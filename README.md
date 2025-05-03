# Dotfiles

Install [nix](https://nixos.org/download.html)
```sh
sh <(curl -L https://nixos.org/nix/install) --daemon
```

Run the bootstrap script
```sh
nix run github:nieg675/dotfiles?dir=nix#bootstrap \
    --extra-experimental-features nix-command \
    --extra-experimental-features flakes

```

[Locale issues on non-NixOS](https://nixos.wiki/wiki/Locales)
```
export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive
```

Populate ~/.git-credentials and /.git-credentials-personal with token in format:
https://<user>:<token>@github.com, e.g. https://nieg675:<token>@github.com

Add `source ~/.config/bash-config/bashrc` in ~/.bashrc
