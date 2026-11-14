{
  description = "Basic example of config.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-repo = {
      url = "github:neovim/neovim/v0.10.1?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    nix-on-droid,
    neovim-repo,
  }:
  let
    system = "aarch64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
    pkgsUnstable = import nixpkgs-unstable {
      inherit system;
    };
    neovimPkg = neovim-repo.packages.${system}.neovim;
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

