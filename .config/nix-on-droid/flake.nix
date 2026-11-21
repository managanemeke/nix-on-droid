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
  }:
  let
    system = "aarch64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
    pkgsUnstable = import nixpkgs-unstable {
      inherit system;
    };
    neovimPkg = pkgsUnstable.neovim-unwrapped.overrideAttrs (old: rec {
      version = "0.11.1";
      src = pkgs.fetchFromGitHub {
        owner = "neovim";
        repo = "neovim";
        tag = "v${version}";
        hash = "sha256-kJvKyNjpqIKa5aBi62jHTCb1KxQ4YgYtBh/aNYZSeO8=";
      };
    });
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
