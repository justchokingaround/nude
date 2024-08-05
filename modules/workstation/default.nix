{
  imports = [
    ./options

    ./gaming.nix
    ./packages.nix
    ./home-manager.nix
    ./wgnord.nix
    ./transmission.nix
  ];

  services = {
    resolved = {
      enable = true;
      dnssec = "false";
      domains = ["~."];
      fallbackDns = ["1.1.1.1" "8.8.8.8"];
    };

    wgnord = {
      enable = true;
      tokenFile = "/home/chomsky/dox/nordvpn.txt";
      country = "France";
    };
  };

  virtualisation.docker.enable = true;
}
