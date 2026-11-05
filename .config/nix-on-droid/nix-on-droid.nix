{
  config,
  lib,
  pkgs,
  ...
}:
{
  # Simply install just the packages
  environment.packages = with pkgs;
  [
    curl
    openssh
    vim

    git
    git-annex
    lua5_1
    luarocks
    neovim

    # Some common stuff that people expect

    #procps
    #killall
    #diffutils
    #findutils
    #utillinux
    #tzdata
    #hostname
    #man
    #gnugrep
    #gnupg
    #gnused
    #gnutar
    #bzip2
    #gzip
    #xz
    #zip
    #unzip
  ];

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

