{
  description = "Basic example of config.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self,
    nixpkgs,
    nix-on-droid,
    neovim-nightly-overlay,
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
              neovim-nightly-overlay.packages.aarch64-linux.default;
          }
        ];
      };
  };
}
