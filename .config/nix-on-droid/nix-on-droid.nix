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
    pkgsUnstable.just

    pkgsUnstable.go

    pkgsUnstable.rustup
    gcc
    pkg-config
    gnumake

    pkgsUnstable.python3
    pkgsUnstable.uv

    gawk
    gnugrep
    gnused
    gnutar

    git
    git-annex
    pkgsUnstable.lua5_1
    pkgsUnstable.luarocks
    neovimPkg

    pkgsUnstable.fzf
    pkgsUnstable.fd
    pkgsUnstable.ripgrep

    strace
    findutils

    # ocaml
    ocamlPackages.ocaml
    ocamlPackages.dune_3
    ocamlPackages.findlib

    kotlin
    gradle

    pkgsUnstable.nim
    pkgsUnstable.nimble

    pkgsUnstable.php
    pkgsUnstable.php.packages.composer

    (pkgsUnstable.ruby.withPackages (ps: with ps; [
      cucumber
      nokogiri
    ]))

    pkgsUnstable.deno
    pkgsUnstable.nodejs

    unzip
    zip
    gzip

    # Some common stuff that people expect

    #procps
    #killall
    #diffutils
    #utillinux
    #tzdata
    #hostname
    #man
    #gnupg
    #bzip2
    #xz
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

