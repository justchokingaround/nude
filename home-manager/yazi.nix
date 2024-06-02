{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) getExe';
in {
  programs.yazi = {
    enable = true;
    settings = {
      opener = {
        reveal = [
          {
            exec = "exiftool \"$1\" | $PAGER";
            block = true;
            desc = "Show EXIF";
            for = "unix";
          }
        ];
        play = [
          {
            exec = "mpv \"$@\"";
            orphan = true;
            for = "unix";
          }
          {
            exec = "mediainfo \"$1\" | $PAGER";
            block = true;
            desc = "Show media info";
            for = "unix";
          }
        ];
      };
    };
    keymap = {
      manager.prepend_keymap = [
        {
          on = [
            "w"
          ];
          exec = "shell \"$SHELL\" --block --confirm";
          desc = "Open a shell";
        }
        {
          on = [
            "W"
          ];
          exec = "tasks_show";
          desc = "Show the task manager";
        }
        {
          on = [
            "X"
          ];
          exec = [
            "unyank"
            "escape --select --visual"
          ];
          desc = "Same as Y";
        }
        {
          on = [
            "d"
          ];
          exec = [
            "remove --force"
            "escape --select --visual"
          ];
          desc = "Move to trash";
        }
        {
          on = [
            "e"
          ];
          exec = "shell ${getExe' pkgs.trash-cli "trash-restore"} --block --confirm";
          desc = "Restore files from the trash";
        }
        {
          on = [
            "<Enter>"
          ];
          exec = "plugin --sync smart-enter";
          desc = "Enter directory or open file";
        }
      ];
      input.prepend_keymap = [
        {
          on = ["<Esc>"];
          exec = "close";
          desc = "Cancel input";
        }
      ];
      tasks.prepend_keymap = [
        {
          on = ["W"];
          exec = "close";
          desc = "Hide the task manager";
        }
      ];
    };
  };
}
