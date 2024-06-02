{inputs, ...}: {
  imports = [
    inputs.nur.nixosModules.nur

    ./system.nix
    ./boot.nix
    ./packages.nix
    ./scripts.nix
    ./cachix.nix
    ./environment.nix
    ./values.nix
  ];
}
