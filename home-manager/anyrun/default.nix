{
  inputs,
  osConfig,
  flakePkgs,
  ...
}: let
  inherit (inputs) anyrun;
  packages = flakePkgs.anyrun;
in {
  imports = [anyrun.homeManagerModules.default];

  # For scripts
  home.packages = [packages.stdin];

  programs.anyrun = {
    enable = true;

    config = {
      y.fraction = 0.2;

      hideIcons = false;
      ignoreExclusiveZones = false;
      layer = "overlay";
      hidePluginInfo = true;
      closeOnClick = true;
      showResultsImmediately = false;
      maxEntries = 10;

      plugins = with packages; [
        applications
        rink
        symbols
        shell
        dictionary
        translate
        stdin
      ];
    };
    extraConfigFiles = {
      "applications.ron".text = ''
        Config(
          // Also shows desktop actions
          desktop_actions: true,
          max_entries: 10,
          // For terminal entries
          terminal: Some("${osConfig.values.terminal}"),
        )
      '';
      "shell.ron".text = ''
        Config(
          prefix: "$",
          shell: None
        )
      '';
      "symbols.ron".text = ''
        Config(
          prefix: "%",
          symbols: {
            "shrug": "¯\\_(ツ)_/¯",
          },
          max_entries: 5,
        )
      '';
      "dictionary.ron".text = ''
        Config(
          prefix: ":",
          max_entries: 5
        )
      '';
      "translate.ron".text = ''
        Config(
          prefix: ";",
          language_delimiter: ">",
          max_entries: 3
        )
      '';
    };
    extraCss = builtins.readFile ./style.css;
  };
}
