
{
  description = "Basic example of config.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-repo = {
      url = "github:neovim/neovim/v0.11.0?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self,
    nixpkgs,
    nix-on-droid,
    neovim-repo,
  }: {
    nixOnDroidConfigurations.default =
      nix-on-droid.lib.nixOnDroidConfiguration {
        pkgs = import nixpkgs {
          system = "aarch64-linux";
        };
        modules = [
          ./nix-on-droid.nix
          {
            config._module.args.neovimPkg =
              neovim-repo.packages.aarch64-linux.neovim;
          }
        ];
      }
    ;
  };
}

