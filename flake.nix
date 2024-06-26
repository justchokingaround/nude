{
  description = "My NixOS flake configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    # nixpkgs-small.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    nur.url = "github:nix-community/nur";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nixpkgs is only used for tests, so no don't need to follow it here
    # mhm
    wrapper-manager.url = "github:viperML/wrapper-manager";

    nix-colors.url = "github:misterio77/nix-colors";
    stylix = {
      url = "github:diniamo/stylix/custom";
      inputs.nixpkgs.follows = "home-manager";
    };

    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hyprpicker.url = "github:hyprwm/hyprpicker";
    anyrun.url = "github:Kirottu/anyrun";

    schizofox.url = "github:schizofox/schizofox";

    jerry.url = "github:justchokingaround/jerry";
    lobster.url = "github:justchokingaround/lobster";
    neovim-flake.url = "github:notashelf/nvf";
    hyprwm-contrib.url = "github:hyprwm/contrib";
    helix.url = "github:SoraTenshi/helix/new-daily-driver";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.flake-parts.follows = "flake-parts";
    };
    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: let
    lib' = import ./lib {inherit inputs;};
  in {
    nixosConfigurations = import ./hosts {inherit inputs lib';};
  };
}
