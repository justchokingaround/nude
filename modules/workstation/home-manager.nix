{
  inputs,
  system,
  lib',
  smallPkgs,
  flakePkgs,
  customPkgs,
  wrappedPkgs,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];

  home-manager = {
    verbose = true;
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "old";
    extraSpecialArgs = {
      inherit inputs system flakePkgs customPkgs wrappedPkgs smallPkgs lib';
    };
    users = {
      chomsky = ../../home-manager;
    };
  };
}
