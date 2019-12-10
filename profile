export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export XDG_DATA_DIRS="$HOME/.nix-profile/share:${XDG_DATA_DIRS:-/usr/local/share:/usr/share}"

. "$HOME/.nix-profile/etc/profile.d/nix.sh"
. "$HOME/.nix-profile/etc/profile.d/bash_completion.sh"
. "$HOME/.nix-profile/etc/bash_completion.d/git-prompt.sh"
