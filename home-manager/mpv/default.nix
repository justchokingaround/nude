{
  pkgs,
  customPkgs,
  ...
}: let
  scripts = with pkgs.mpvScripts;
  with customPkgs.mpvScripts; [
    # Missing: skip-intro, clipshot, autosubsync
    uosc
    reload
    thumbfast
    mpris
    mpv-webm
    seekTo
    sponsorblock-minimal
    youtube-upnext

    SimpleUndo
    skiptosilence
  ];
in {
  imports = [
    ./config.nix
    ./binds.nix
    ./profiles.nix
    ./uosc.nix
  ];

  programs.mpv = {
    enable = true;
    package = pkgs.mpv.override {
      inherit scripts;
      youtubeSupport = true;
    };

    scriptOpts = {
      skiptosilence.mutewhileskipping = true;
    };
  };
}
