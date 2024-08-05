{config, ...}: let
  inherit (config.colorScheme) palette;
in {
  services.mako = {
    enable = true;
    defaultTimeout = 5000;
    maxIconSize = 128;
    borderSize = 0;
    format = ''<span foreground="#${palette.base0B}"><b><i>%s</i></b></span>\n<span foreground="#${palette.base0C}">%b</span>'';
    borderRadius = 10;
    padding = "10";
    width = 330;
    height = 200;
  };
}
