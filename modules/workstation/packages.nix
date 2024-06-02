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
in {
  imports = [inputs.hyprland.nixosModules.default];

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
  nixpkgs.config = {allowUnfree = true;};

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
    gcc

    # Text Editors
    zed-editor

    # Web Browsers
    ungoogled-chromium
    librewolf

    # Multimedia
    spotify
    spotify-player
    obs-studio
    chafa

    # Communication
    telegram-desktop

    # Clipboard Management
    wl-clipboard
    cliphist

    # File Management
    gnome.nautilus
    trash-cli

    # Office Suites
    libreoffice

    # Audio Tools
    pulsemixer

    # Download Tools
    yt-dlp

    # Terminal Utilities
    fzf
    lazygit
    libqalculate
    libnotify

    # Networking
    mitmproxy

    # Virtualization
    quickemu
    quickgui

    # System Utilities
    xdragon
    openssl

    # Miscellaneous Tools
    ollama
    tgpt
  ];
}
