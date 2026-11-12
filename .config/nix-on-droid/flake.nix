{
  description = "Basic example of config.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    nix-on-droid,
  }: let
    pkgs = import nixpkgs {
      system = "aarch64-linux";
    };
    pkgs-unstable = import nixpkgs-unstable {
      system = "aarch64-linux";
    };
  in {
    nixOnDroidConfigurations.default =
      nix-on-droid.lib.nixOnDroidConfiguration {
        inherit pkgs;
        modules = [
          ./nix-on-droid.nix
          {
            config._module.args.neovimPkg = pkgs-unstable.neovim;
          }
        ];
      };
  };
}

