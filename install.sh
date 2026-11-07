#!/data/data/com.termux/files/usr/bin/bash

mkdir -p ~/.config/nix-on-droid/

curl -fL \
  -o ~/.config/nix-on-droid/flake.nix \
  https://raw.githubusercontent.com/managanemeke/nix-on-droid/main/.config/nix-on-droid/flake.nix

curl -fL \
  -o ~/.config/nix-on-droid/nix-on-droid.nix \
  https://raw.githubusercontent.com/managanemeke/nix-on-droid/main/.config/nix-on-droid/nix-on-droid.nix

nix-on-droid switch \
  --flake ~/.config/nix-on-droid

