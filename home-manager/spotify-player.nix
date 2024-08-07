{
  config,
  pkgs,
  ...
}: {
  disabledModules = ["programs/spotify-player.nix"];
  imports = [./custom/spotify-player.nix];

  programs.spotify-player = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      client_id = "65b708073fc0480ea92a077233ca87bd";
      client_port = 8080;
      play_icon = " ";
      pause_icon = " ";
      enable_media_control = true;
      default_device = "spotify-player";
      theme = config.stylix.base16Scheme.slug;
      seek_duration_secs = 10;
      playback_window_position = "Bottom";
      liked_icon = " ";
      border_type = "Hidden";
      progress_bar_type = "Rectangle";
      cover_img_scale = 1.5;
      player_event_hook_command.command = pkgs.writeShellScript "waybarHook" ''
        sleep 1
        curl "$(playerctl -p spotify_player metadata mpris:artUrl)" > /tmp/cover.jpg
        pkill -RTMIN+8 waybar
      '';
      device = {
        name = "spotify-player";
        device_type = "speaker";
        bitrate = 320;
        audio_cache = false;
        autoplay = true;
      };
    };
    actions = [
      {
        action = "ToggleLiked";
        key_sequence = "C-l";
      }
      {
        action = "AddToLibrary";
        key_sequence = "C-a";
      }
      {
        action = "Follow";
        key_sequence = "C-f";
      }
    ];
    keymaps = [
      {
        command = "PreviousPage";
        key_sequence = "esc";
      }
      {
        command = "ClosePopup";
        key_sequence = "q";
      }
      {
        command = "Repeat";
        key_sequence = "R";
      }
      {
        command = "VolumeUp";
        key_sequence = "=";
      }
      {
        command = "Shuffle";
        key_sequence = "S";
      }
      {
        command = "Quit";
        key_sequence = "C-c";
      }
      {
        command = "SeekForward";
        key_sequence = "L";
      }
      {
        command = "SeekBackward";
        key_sequence = "H";
      }
      {
        command = "PageSelectPreviousOrScrollUp";
        key_sequence = "C-u";
      }
      {
        command = "PageSelectNextOrScrollDown";
        key_sequence = "C-d";
      }
      {
        command = "LikedTrackPage";
        key_sequence = "g o";
      }
    ];
    themes = [
      {
        name = config.stylix.base16Scheme.slug;
        palette = with config.lib.stylix.colors.withHashtag; {
          black = base00;
          foreground = base03;
          bright_black = base01;
          yellow = base02;
          green = base03;
          bright_yellow = base04;
          white = base05;
          bright_white = base06;
          cyan = base07;
          bright_cyan = base08;
          blue = base09;
          bright_red = base0A;
          bright_blue = base0B;
          red = base0C;
          bright_green = base0D;
          magenta = base07;
          bright_magenta = base0F;
        };
        component_style = {
          block_title = {
            fg = "BrightGreen";
            modifiers = ["Italic" "Bold"];
          };
          playback_track = {
            fg = "BrightMagenta";
            modifiers = ["Italic"];
          };
          playback_album = {
            fg = "BrightRed";
            modifiers = ["Italic"];
          };
          playback_artists = {
            fg = "BrightCyan";
            modifiers = [];
          };
          playback_metadata = {
            fg = "BrightBlue";
            modifiers = [];
          };
          playback_progress_bar = {
            fg = "BrightGreen";
            modifiers = ["Italic"];
          };
          current_playing = {
            fg = "Red";
            modifiers = ["Bold" "Italic"];
          };
          playlist_desc = {
            fg = "White";
            modifiers = ["Italic"];
          };
          page_desc = {
            fg = "Magenta";
            modifiers = ["Bold" "Italic"];
          };
          table_header = {
            fg = "Blue";
            modifiers = ["Bold"];
          };
          border = {fg = "BrightYellow";};
          selection = {
            fg = "Red";
            modifiers = ["Bold" "Reversed"];
          };
          secondary_row = {bg = "BrightBlack";};
        };
      }
    ];
  };
}
