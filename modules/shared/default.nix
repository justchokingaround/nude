{inputs, ...}: {
  imports = [
    inputs.nur.nixosModules.nur
    inputs.sops-nix.nixosModules.sops

    ./system.nix
    ./boot.nix
    ./packages.nix
    ./scripts.nix
    ./cachix.nix
    ./environment.nix
    ./values.nix
  ];
}
