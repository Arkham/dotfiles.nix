# Dotfiles.nix

Dotfiles, powered by [Nix](https://nixos.org/nix/) and [home-manager](https://github.com/rycee/home-manager).

## How to use

1. Install Nix:
   ```bash
   $ sh <(curl -L https://nixos.org/nix/install)
   ```
1. Enable [Nix Flakes](https://www.tweag.io/blog/2020-05-25-flakes):
   ```bash
   $ mkdir -p ~/.config/nix

   $ cat <<EOF >> ~/.config/nix/nix.conf
   experimental-features = nix-command flakes
   EOF

   $ sudo launchctl kickstart -k system/org.nixos.nix-daemon
   ```
1. Go inside your `~/.config` directory and clone this repo:
   ```bash
   $ mkdir ~/.config && cd ~/.config && \
     git clone https://github.com/Arkham/dotfiles.nix.git nixpkgs && cd nixpkgs
   ```
1. Run the flake and activate your env:
   ```bash
   $ nix run . && home-manager switch -b backup
   ```
1. Then you can update it with:
   ```bash
   $ nix flake update && home-manager switch
   ```
