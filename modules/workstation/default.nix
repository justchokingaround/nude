{
  imports = [
    ./options

    ./gaming.nix
    ./packages.nix
    ./home-manager.nix
  ];

  virtualisation.docker.enable = true;
}
