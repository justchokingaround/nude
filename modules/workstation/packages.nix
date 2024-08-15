{
  pkgs,
  inputs,
  config,
  ...
}: let
  inherit (config) values;
  xdgPortalName = config.xdg.portal.name;

  wrapped = inputs.wrapper-manager.lib.build {
    inherit pkgs;
    modules = [
      {
        wrappers = {
          discord = {basePackage = pkgs.vesktop;};
          obsidian = {basePackage = pkgs.obsidian;};
        };
      }
    ];
  };

  customInvidtui = pkgs.invidtui.overrideAttrs (oldAttrs: {
    postPatch =
      oldAttrs.postPatch
      + ''
        substituteInPlace cmd/flags.go \
          --replace "\"${pkgs.lib.getBin pkgs.mpv}/bin/mpv\"" "\"${config.home-manager.users.chomsky.programs.mpv.package}/bin/mpv\""
      '';
  });
in {
  imports = [
    inputs.hyprland.nixosModules.default
  ];
  # sops.secrets.nord-vpn.sopsFile = ../../secrets/secrets.yaml;

  programs = {
    hyprland.enable = true;
    zsh.enable = true;
    nix-ld = {enable = true;};
  };

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs."xdg-desktop-portal-${xdgPortalName}"];
    config.common.default = ["hyprland" "${xdgPortalName}"];
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
  services = {
    pipewire = {
      enable = true;
      wireplumber.enable = true;
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;
    };
    power-profiles-daemon.enable = true;
    blueman.enable = true;
  };

  users.users.${values.mainUser}.shell = config.home-manager.users.${values.mainUser}.programs.zsh.package;
  # For electron apps
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "kew"
      "freeimage-unstable-2021-11-01"
    ];
  };

  fonts.packages = with pkgs; [
    inter
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    noto-fonts-extra
    iosevka-comfy.comfy
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
    (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
  ];

  environment.systemPackages = with pkgs; [
    wrapped

    # Development Tools
    jetbrains.idea-ultimate
    jetbrains.rust-rover
    neovide
    pkg-config
    cargo
    rustc
    rust-analyzer
    rustfmt
    clippy
    # rustup
    gcc
    just
    go
    neovim
    vscode-extensions.vadimcn.vscode-lldb.adapter
    file

    # Text Editors
    zed-editor

    # Web Browsers
    ungoogled-chromium
    librewolf

    # Multimedia
    spotify
    # spotify-player
    obs-studio
    chafa
    ffmpeg
    customInvidtui
    # customPkgs.kew

    # Communication
    telegram-desktop
    discordo
    nchat
    neomutt
    element-desktop
    cinny-desktop

    # Clipboard Management
    wl-clipboard
    cliphist

    # File Management
    gnome.nautilus
    trash-cli

    # Office Suites
    libreoffice

    # Epub Reader
    librum

    # Audio Tools
    pulsemixer

    # Download Tools
    yt-dlp

    # Terminal Utilities
    lazygit
    libqalculate
    libnotify

    # Networking
    mitmproxy
    # config.nur.repos.LuisChDev.nordvpn

    # Virtualization
    quickemu
    quickgui

    # System Utilities
    xdragon
    openssl

    # Passwords
    sops
    bitwarden-cli

    # Torrenting
    qbittorrent
    # transmission_4-gtk
    aria2

    # Gaming
    heroic
    lutris
    protonup-qt

    # Remarkable Table
    restream

    # Blog
    surge-cli
    zola

    # Virtualization
    spice

    # Miscellaneous Tools
    wezterm
    cool-retro-term
    ollama
    tgpt
    gimp
    appimage-run
  ];
}
