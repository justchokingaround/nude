{
  imports = [
    ./options

    ./gaming.nix
    ./packages.nix
    ./home-manager.nix
    ./wgnord.nix
  ];

  services.resolved = {
    enable = true;
    dnssec = "false";
    domains = ["~."];
    fallbackDns = ["1.1.1.1" "8.8.8.8"];
  };

  services.wgnord = {
    enable = true;
    tokenFile = "/home/chomsky/dox/nordvpn.txt";
    country = "Bulgaria";
  };

  virtualisation.docker.enable = true;
}
