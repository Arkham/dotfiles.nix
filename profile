export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export XDG_DATA_DIRS="$HOME/.nix-profile/share:${XDG_DATA_DIRS:-/usr/local/share:/usr/share}"

if [[ -f "$HOME/.nix-profile/etc/profile.d/nix-daemon.sh" ]]; then
  . "$HOME/.nix-profile/etc/profile.d/nix-daemon.sh"
else
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

if [[ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]]; then
  . "$HOME/.nix-profile/etc/profile.d/nix.sh"
else
  . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
fi

. "$HOME/.nix-profile/etc/profile.d/bash_completion.sh"
. "$HOME/.nix-profile/share/git/contrib/completion/git-prompt.sh"
