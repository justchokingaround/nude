{config, lib, pkgs, ...}:
let
    gitIdentity = pkgs.writeShellScriptBin "git-identity" (builtins.readFile ./git-identity);
in
{
  home.packages = with pkgs; [
    gitIdentity
    fzf
  ];

  programs.gh = {
    enable = true;
    extensions = [pkgs.gh-dash];
  };

  programs.git = {
    enable = true;
    delta.enable = false;
    difftastic = {
        enable = true;
        background = "dark";
        display = "side-by-side-show-both";
    };

    extraConfig = {

      # extremely important, otherwise git will attempt to guess a default user identity. see `man git-config` for more details
      user.useConfigOnly = true;

      user.github.name = "justchokingaround";
      user.github.email = "ivanonarch@tutanota.com";

      user.codeberg.name = "choker";
      user.codeberg.email = "chomker@proton.me";

      aliases = {
        identity = "! git-identity";
        id = "! git-identity";
      };

      url = {
        core = {
          sshCommand = "ssh -i ~/.ssh/github_main.pub -o IdentitiesOnly=yes -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no";
        };
        "git@github.com:" = {
          insteadOf = "https://github.com/";
        };
        "git@codeberg.org:" = {
          insteadOf = "https://codeberg.org/";
        };
      };
    };
  };
}
