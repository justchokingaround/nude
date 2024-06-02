{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: let
  inherit (inputs) spicetify-nix;
  spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
in {
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "spotify"
    ];
  imports = [spicetify-nix.homeManagerModule];

  programs.spicetify = {
    enable = true;

    # Package, using an overide to enable wayland support
    spotifyPackage = let
      spotify-wayland = pkgs.spotify.overrideAttrs (old: rec {
        commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
      });
    in
      spotify-wayland;

    theme = spicePkgs.themes.Orchis;

    colorScheme = "custom";

    customColorScheme = {
      text = "${config.colorScheme.colors.base06}";
      subtext = "${config.colorScheme.colors.base06}";
      sidebar-text = "${config.colorScheme.colors.base0E}";
      main = "${config.colorScheme.colors.base00}";
      sidebar = "${config.colorScheme.colors.base00}";
      player = "${config.colorScheme.colors.base00}";
      card = "${config.colorScheme.colors.base00}";
      shadow = "${config.colorScheme.colors.base00}";
      selected-row = "${config.colorScheme.colors.base02}";
      button = "${config.colorScheme.colors.base0E}";
      button-button = "${config.colorScheme.colors.base0E}";
      button-disabled = "${config.colorScheme.colors.base09}";
      tab-active = "${config.colorScheme.colors.base0C}";
      notification = "${config.colorScheme.colors.base0E}";
      notification-error = "${config.colorScheme.colors.base0A}";
      misc = "${config.colorScheme.colors.base0B}";
    };

    enabledExtensions = with spicePkgs.extensions; [
      playlistIcons
      genre
      historyShortcut
      keyboardShortcut
      copyToClipboard
      hidePodcasts
      fullAppDisplay
      shuffle
    ];

    #Custom apps
    enabledCustomApps = with spicePkgs.apps; [
      new-releases
      marketplace
      localFiles
      lyrics-plus
    ];
  };
}
