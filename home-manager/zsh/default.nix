{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) getExe getExe';
in {
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";

    history = {
      share = true;
      path = "${config.xdg.dataHome}/zsh/zsh_history";
      extended = true;
      expireDuplicatesFirst = true;
      ignoreAllDups = true;
      ignoreSpace = true;
    };

    # TODO: proper login manager
    initExtraFirst = ''
      [[ "$(tty)" == "/dev/tty1" ]] && exec Hyprland

      ZSH_AUTOSUGGEST_STRATEGY=(history completion)

      # This is needed because otherwise, keybinds (from other plugins too) are overwritten, and it's hard to get around that
      ZVM_INIT_MODE="sourcing"
    '';

    initExtra = ''
      ${import ./opts.nix {inherit (lib) concatStringsSep;}}

      autoload -Uz up-line-or-beginning-search
      autoload -Uz down-line-or-beginning-search
      zle -N up-line-or-beginning-search
      zle -N down-line-or-beginning-search

      bindkey "^U" kill-whole-line
      bindkey "^H" backward-kill-word
      bindkey "^[[3;5~" kill-word

      bindkey "^A" autosuggest-execute
      bindkey -M vicmd "^A" autosuggest-execute
      bindkey -M vicmd "k" up-line-or-beginning-search
      bindkey -M vicmd "j" down-line-or-beginning-search

      # Can't have these in shellAliases due to escaping
      alias -s git="git clone"

      source ${./hooks.zsh}
      source ${./funcs.zsh}
    '';

    shellAliases = with pkgs; {
      # Needed for aliases
      sudo = "sudo ";
      listxwl = "hyprctl -j clients | jq -r '.[] | select( [ .xwayland == true ] | any ) | .title' | awk 'NF'";
      v = "nvim";
      # Create a file with execute permissions
      xtouch = "install /dev/null";
      rm = "${getExe' rmtrash "rmtrash"}";
      rmd = "command rm";
      hash = "sha256sum";
      copy = "wl-copy";
      paste = "wl-paste";
      ip = "${getExe dig} @resolver4.opendns.com myip.opendns.com +short";
      ip4 = "${getExe dig} @resolver4.opendns.com myip.opendns.com +short -4";
      ip6 = "${getExe dig} @resolver1.ipv6-sandbox.opendns.com AAAA myip.opendns.com +short -6";
      mp = "mkdir -p";
      page = "$PAGER";
      open = "xdg-open";
      n = "nix";
      shell = "nix-shell";
      dev = "nix develop";
      update-input = "nix flake lock --update-input";
      # nix-clean = "sudo nix-collect-garbage --delete-older-than 3d; nix-collect-garbage -d";
      size = "du -sh";
      "jj" = "cd -";

      # eza
      ls = "eza --git --icons --color=auto --group-directories-first";
      l = "ls -lh --time-style=long-iso";
      ll = "l -a";
      la = "ls -a";
      tree = "ls --tree";
      lt = "tree";

      # git
      lg = "lazygit";
      g = "git";
      gp = "git pull";
      gst = "git status";

      # nvim
      nv = "nvim";
    };

    plugins = with pkgs; [
      # vi mode must be first
      {
        name = "zsh-vi-mode";
        src = zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
      {
        name = "zsh-nix-shell";
        src = zsh-nix-shell;
        file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
      }
      {
        name = "zsh-autosuggestions";
        src = zsh-autosuggestions;
        file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
      }
      {
        name = "fzf-tab";
        src = zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
      {
        name = "fast-syntax-highlighting";
        src = zsh-fast-syntax-highlighting;
        file = "share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh";
      }
      {
        name = "zsh-autopair";
        src = zsh-autopair;
        file = "share/zsh/zsh-autopair/autopair.zsh";
      }
      {
        name = "zsh-fzf-history-search";
        src = zsh-fzf-history-search;
        file = "share/zsh-fzf-history-search/zsh-fzf-history-search.plugin.zsh";
      }
      {
        name = "forgit";
        src = zsh-forgit;
        file = "share/zsh/zsh-forgit/forgit.plugin.zsh";
      }
    ];
  };
}
