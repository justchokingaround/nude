{config, ...}: {
  imports = [
    ./custom/satty.nix
  ];

  programs = {
    satty = {
      enable = true;
      settings = {
        general = {
          early-exit = true;
          initial-tool = "brush";
          copy-command = "wl-copy";
          annotation-size-factor = 1;
          save-after-copy = false;
          primary-highlighter = "block";
        };
        font.family = config.stylix.fonts.sansSerif.name;
      };
    };
  };
}
