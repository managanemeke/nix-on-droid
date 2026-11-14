{
  config,
  lib,
  pkgs,
  neovimPkg,
  pkgsUnstable,
  ...
}:
{
  # Simply install just the packages
  environment.packages = with pkgs;
  [
    curl
    openssh
    vim
    wget
    zsh

    pkgsUnstable.nushell
    just

    python3
    pkgsUnstable.uv

    gawk
    gnugrep
    gnused
    gnutar

    git
    git-annex
    lua5_1
    luarocks
    neovimPkg

    # ocaml
    ocamlPackages.ocaml
    ocamlPackages.dune_3
    ocamlPackages.findlib

    # Some common stuff that people expect

    #procps
    #killall
    #diffutils
    #findutils
    #utillinux
    #tzdata
    #hostname
    #man
    #gnupg
    #bzip2
    #gzip
    #xz
    #zip
    #unzip
  ];

  environment.sessionVariables = {
    NIX_ON_DROID = "1";
  };

  # Backup etc files instead of failing
  # to activate gene ration if a file
  # already exists in /etc
  environment.etcBackupExtension = ".bak";

  # Read the changelog before changing
  # this value
  system.stateVersion = "24.05";

  # Set up nix for flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Set your time zone
  time.timeZone = "Europe/Yekaterinburg";
}

