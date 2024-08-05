{
  pkgs,
  config,
  ...
}: let
  inherit (pkgs) mpc-cli playerctl imagemagick inotify-tools cava streamrip html-xml-utils pup;
  inherit (config.xdg.userDirs) music;

  musicDirectory = music;
  changeScript = "ncmpcpp/on-song-change.sh";
  fallbackImage = ../modules/shared/wallpapers/wallpaper.jpg;
in {
  home.packages = [mpc-cli playerctl imagemagick inotify-tools cava streamrip html-xml-utils pup];

  services = {
    mpdris2.enable = true;
    playerctld.enable = true;
    mpd = {
      enable = true;
      inherit musicDirectory;
      dataDir = "${config.home.homeDirectory}/.config/mpd";
      extraConfig = ''
        auto_update           "yes"
        restore_paused        "yes"
        audio_output {
          type "pulse"
          name "Pulseaudio"
        }
        audio_output {
        	type                "fifo"
        	name                "Visualizer"
        	format              "44100:16:2"
        	path                "/tmp/mpd.fifo"
        }
      '';
      network.startWhenNeeded = true;
    };
  };

  xdg.configFile.${changeScript} = {
    executable = true;
    text =
      /*
      bash
      */
      ''
        #!/usr/bin/env bash
        find_cover () {
          ext="$(mpc --format %file% current | sed 's/^.*\.//')"

          if [ "$ext" == "flac" ]; then
            metaflac --export-picture-to=/tmp/cover.jpg \
            "$(mpc --format "${musicDirectory}"/%file% current)" && cover_path="/tmp/cover.jpg" && return
          else
            ffmpeg -y -i "$(mpc --format "${musicDirectory}"/%file% | head -n 1)" \
            /tmp/cover.jpg && cover_path="/tmp/cover.jpg" && return
          fi

          file="${musicDirectory}/$(mpc --format %file% current)"
          album="''${file%/*}"
          cover_path=$(find "$album" -maxdepth 1 | grep -m 1 ".*\.\(jpg\|png\|gif\|bmp\)")
        }
        find_cover 2>/dev/null
        magick "''${cover_path:-${fallbackImage}}" /tmp/cover.jpg
        notify-send -i "''${cover_path:-${fallbackImage}}" "Now Playing" "$(mpc current)" -h string:x-dunst-stack-tag:vol 2>/dev/null
      '';
  };

  programs.ncmpcpp = {
    enable = true;

    bindings = [
      {
        key = "+";
        command = "show_clock";
      }
      {
        key = "=";
        command = "volume_up";
      }
      {
        key = "j";
        command = "scroll_down";
      }
      {
        key = "k";
        command = "scroll_up";
      }
      {
        key = "ctrl-u";
        command = "page_up";
      }
      {
        key = "ctrl-d";
        command = "page_down";
      }
      {
        key = "u";
        command = "page_up";
      }
      {
        key = "d";
        command = "page_down";
      }
      {
        key = "h";
        command = "previous_column";
      }
      {
        key = "l";
        command = "next_column";
      }
      {
        key = ".";
        command = "show_lyrics";
      }
      {
        key = ">";
        command = "next_found_item";
      }
      {
        key = "<";
        command = "previous_found_item";
      }
      {
        key = "J";
        command = "move_sort_order_down";
      }
      {
        key = "K";
        command = "move_sort_order_up";
      }
      {
        key = "h";
        command = "jump_to_parent_directory";
      }
      {
        key = "l";
        command = ["enter_directory" "run_action" "play_item"];
      }
      {
        key = "m";
        command = ["show_media_library" "toggle_media_library_columns_mode"];
      }
      {
        key = "t";
        command = "show_tag_editor";
      }
      {
        key = "v";
        command = "show_visualizer";
      }
      {
        key = "G";
        command = "move_end";
      }
      {
        key = "g";
        command = "move_home";
      }
      {
        key = "U";
        command = "update_database";
      }
      {
        key = "s";
        command = ["reset_search_engine" "show_search_engine"];
      }
      {
        key = "f";
        command = ["show_browser" "change_browse_mode"];
      }
      {
        key = "x";
        command = ["delete_playlist_items"];
      }
      {
        key = "P";
        command = ["show_playlist"];
      }
      {
        key = " ";
        command = "pause";
      }
      {
        key = "n";
        command = "next";
      }
      {
        key = "p";
        command = "previous";
      }
      {
        key = "right";
        command = "seek_forward";
      }
      {
        key = "left";
        command = "seek_backward";
      }
    ];

    settings = {
      ncmpcpp_directory = "~/.config/ncmpcpp";
      execute_on_song_change = "~/.config/${changeScript}";

      # Miscelaneous
      ignore_leading_the = true;
      external_editor = "nvim";
      message_delay_time = 1;
      playlist_disable_highlight_delay = 2;
      autocenter_mode = "yes";
      centered_cursor = "yes";
      allow_for_physical_item_deletion = "yes";
      lines_scrolled = "0";
      follow_now_playing_lyrics = "yes";
      lyrics_fetchers = "musixmatch";

      # visualizer
      visualizer_data_source = "/tmp/mpd.fifo";
      visualizer_output_name = "mpd_visualizer";
      visualizer_type = "ellipse";
      visualizer_look = "●●";
      visualizer_color = "blue, green";

      # appearance
      colors_enabled = "yes";
      playlist_display_mode = "classic";
      user_interface = "classic";
      volume_color = "white";

      # window
      song_window_title_format = "Music";
      statusbar_visibility = "no";
      header_visibility = "no";
      titles_visibility = "no";
      # progress bar
      progressbar_look = "▃▃▃";
      progressbar_color = "black";
      progressbar_elapsed_color = "blue";

      # song list
      song_status_format = "$7%t";
      song_list_format = "{$(008)%t}|{$(008)%a}|{$(008)%f}";
      song_columns_list_format = "(53)[blue]{tr} (45)[blue]{a}";

      current_item_prefix = "$b$2| ";
      current_item_suffix = "$/b$5";

      now_playing_prefix = "$b$5| ";
      now_playing_suffix = "$/b$5";

      song_library_format = "{{%a - %t} (%b)}|{%f}";

      # colors
      main_window_color = "blue";

      current_item_inactive_column_prefix = "$b$5";
      current_item_inactive_column_suffix = "$/b$5";

      color1 = "white";
      color2 = "blue";
    };
  };
}
