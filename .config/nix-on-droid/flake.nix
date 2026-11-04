{
  description =
    "Basic example of Nix-on-Droid config."
  ;
  inputs = {
    nixpkgs.url =
      "github:NixOS/nixpkgs/nixos-24.05"
    ;
    nix-on-droid = {
      let repository =
        "nix-community/nix-on-droid"
      ;
      let release = "release-24.05";
      url = "github:${repository}/${release}";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self,
    nixpkgs,
    nix-on-droid,
  }: {
    nixOnDroidConfigurations.default =
      nix-on-droid.lib.nixOnDroidConfiguration {
        pkgs = import nixpkgs {
          system = "aarch64-linux";
        };
        modules = [
          ./nix-on-droid.nix
        ];
      }
    ;
  };
}

