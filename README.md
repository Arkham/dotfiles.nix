# Dotfiles.nix

Dotfiles, powered by [Nix](https://nixos.org/nix/) and [home-manager](https://github.com/rycee/home-manager).

## How to use

1. Install Nix from [determinate systems](https://docs.determinate.systems/)
1. Go inside your `~/.config` directory and clone this repo:
   ```bash
   $ mkdir -p ~/.config && cd ~/.config && \
     git clone https://github.com/Arkham/dotfiles.nix.git home-manager && \
     cd home-manager
   ```
1. Run the flake and activate your env:
   ```bash
   $ nix run . && home-manager switch -b backup
   ```
1. Then you can update it with:
   ```bash
   $ nix flake update && home-manager switch
   ```
