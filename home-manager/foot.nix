{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (config.colorScheme) palette;
in {
  programs.foot = {
    enable = true;
    package = pkgs.foot;
    settings = {
      main = {
        term = "xterm-256color";
        selection-target = "clipboard";
        font = lib.mkForce "Liga SFMono Nerd Font:size=16";
        pad = "30x30";
        dpi-aware = "no";
        notify = "${pkgs.libnotify}/bin/notify-send -a foot -i foot \${title} \${body}";
      };
      url.launch = "${pkgs.xdg-utils}/bin/xdg-open \${url}";
      scrollback = {
        lines = 10000;
      };
      tweak = {
        font-monospace-warn = "no";
      };
      cursor = {
        style = "underline";
        underline-thickness = "3px";
      };
      mouse = {
        hide-when-typing = "yes";
      };
      colors = {
        background = "${palette.base00}";
        foreground = "${palette.base06}";
        regular0 = "${palette.base00}";
        regular1 = "${palette.base0B}";
        regular2 = "${palette.base0C}";
        regular3 = "${palette.base0D}";
        regular4 = "${palette.base07}";
        regular5 = "${palette.base0F}";
        regular6 = "${palette.base09}";
        regular7 = "${palette.base04}";
        bright0 = "${palette.base03}";
        bright1 = "${palette.base0B}";
        bright2 = "${palette.base0C}";
        bright3 = "${palette.base0D}";
        bright4 = "${palette.base07}";
        bright5 = "${palette.base0F}";
        bright6 = "${palette.base09}";
        bright7 = "${palette.base06}";
      };
    };
  };
}
