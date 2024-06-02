{
  imports = [
    ./options

    ./packages.nix
    ./home-manager.nix
  ];

  virtualisation.docker.enable = true;
}
