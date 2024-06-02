{
  inputs,
  lib,
  ...
}: let
  inherit (lib) nixosSystem;
  inherit (import ./mappers.nix) inputsToPackages;

  mkNixosSystem = args @ {
    system,
    modules,
    ...
  }: let
    pkgs = inputs.nixpkgs.legacyPackages.${system};
    smallPkgs = inputs.nixpkgs-small.legacyPackages.${system};

    flakePkgs = inputsToPackages inputs system;
    customPkgs = import ../packages {inherit pkgs;};
    wrappedPkgs = import ../wrappers {inherit inputs pkgs;};
  in
    nixosSystem {
      inherit system modules;
      # We can't pass lib because that's from nixpkgs, and we need the extended version
      specialArgs = {inherit inputs system flakePkgs customPkgs wrappedPkgs smallPkgs;} // args.specialArgs or {};
    };
in {
  inherit mkNixosSystem;
}
