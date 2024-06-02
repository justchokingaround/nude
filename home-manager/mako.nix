{
  lib,
  config,
  ...
}: let
  inherit (config.colorScheme) palette;
in {
  services.mako = {
    enable = true;
    sort = "+time";
    layer = "overlay";
    defaultTimeout = 5000;
    maxVisible = 50;

    anchor = "top-right";
    margin = "10,10,0,0";
    width = 350;
    height = 1000;
    padding = "12";
    maxIconSize = 128;

    font = lib.mkForce "Iosevka Comfy Italic 12";

    backgroundColor = lib.mkForce "#${palette.base00}";
    borderColor = lib.mkForce "#${palette.base06}";
    borderRadius = 14;
    borderSize = 2;

    extraConfig = lib.mkForce ''
      format=<span foreground='#${palette.base0E}' size='14000' weight='bold'>%s</span>\n%b
      text-alignment=center
    '';
  };
}
