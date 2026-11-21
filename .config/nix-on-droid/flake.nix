{
  description = "Basic example of config.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-neovim.url = "github:NixOS/nixpkgs/11cb3517b3af6af300dd6c055aeda73c9bf52c48";
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    nixpkgs-neovim,
    nix-on-droid,
  }:
  let
    system = "aarch64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
    pkgsUnstable = import nixpkgs-unstable {
      inherit system;
    };
    neovimPkg = (import nixpkgs-neovim {
      inherit system;
    }).neovim-unwrapped;
  in {
    nixOnDroidConfigurations.default =
      nix-on-droid.lib.nixOnDroidConfiguration {
        inherit pkgs;
        modules = [
          ./nix-on-droid.nix
          {
            config._module.args.neovimPkg = neovimPkg;
          }
        ];
        extraSpecialArgs = {
          inherit pkgsUnstable;
        };
      };
  };
}

