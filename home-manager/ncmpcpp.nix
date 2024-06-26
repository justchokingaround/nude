{
  pkgs,
  config,
  ...
}: let
  inherit (pkgs) mpc-cli;
  inherit (config.xdg.userDirs) music;

  musicDirectory = music;
  changeScript = "ncmpcpp/on-song-change.sh";
  fallbackImage = ../modules/shared/wallpapers/wallpaper.jpg;
in {
  home.packages = [mpc-cli];

  services.mpd = {
    enable = true;
    inherit musicDirectory;

    extraConfig = ''
      auto_update "yes"
    '';
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
        notify-send -i "''${cover_path:-${fallbackImage}}" "Now Playing" "$(mpc current)" 2>/dev/null
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
    ];

    settings = {
      ncmpcpp_directory = "~/.config/ncmpcpp";
      autocenter_mode = "no";
      mouse_support = "yes";
      execute_on_song_change = "~/.config/${changeScript}";
      mpd_crossfade_time = 3;
      allow_for_physical_item_deletion = "no";
      # GENERAL
      lyrics_directory = "~/.config/ncmpcpp/lyrics";
      connected_message_on_startup = "yes";
      cyclic_scrolling = "yes";
      mouse_list_scroll_whole_page = "yes";
      lines_scrolled = "1";
      message_delay_time = "1";
      playlist_shorten_total_times = "yes";
      playlist_display_mode = "columns";
      browser_display_mode = "columns";
      search_engine_display_mode = "columns";
      playlist_editor_display_mode = "columns";
      centered_cursor = "yes";
      user_interface = "classic";
      follow_now_playing_lyrics = "yes";
      locked_screen_width_part = "50";
      ask_for_locked_screen_width_part = "yes";
      display_bitrate = "no";
      main_window_color = "white";
      startup_screen = "playlist";
      # PROGRESS BAR
      progressbar_look = "━━━";
      progressbar_elapsed_color = "magenta";
      progressbar_color = "black";
      # UI VISIBILITY
      header_visibility = "no";
      statusbar_visibility = "yes";
      titles_visibility = "yes";
      enable_window_title = "yes";
      # COLORS
      statusbar_color = "white";
      # UI APPEARANCE
      now_playing_prefix = "$b$2$7 ";
      now_playing_suffix = "  $/b$8";
      current_item_prefix = "$b$2$/b$2 ";
      current_item_suffix = "  $8";
      song_columns_list_format = "(50)[]{t|fr:Title} (45)[green]{l}";
      song_list_format = " {%t $R   $8%a$8}|{%f $R   $8%l$8} $8";
      song_status_format = "$b$6$7[$8      $7]$6 $2 $7{$8 %b }|{$8 %t }|{$8 %f }$7 $8";
      song_window_title_format = "Now Playing ..";
    };
  };
}
