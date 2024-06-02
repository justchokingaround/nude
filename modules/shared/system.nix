{
  config,
  inputs,
  pkgs,
  ...
}: {
  nix = {
    settings = {
      accept-flake-config = true;
      warn-dirty = false;
      trusted-users = ["root" "@wheel"];
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      builders-use-substitutes = true;

      log-lines = 30;
      http-connections = 50;
    };

    registry = {
      nixpkgs.flake = inputs.nixpkgs;
    };

    nixPath = [
      "nixpkgs=/etc/nix/inputs/nixpkgs"
    ];
  };

  environment.etc = {
    "nix/inputs/nixpkgs".source = inputs.nixpkgs.outPath;
  };

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-122n.psf.gz";
    packages = with pkgs; [terminus_font];
  };

  users.users.${config.values.mainUser} = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "docker"];
  };
}
