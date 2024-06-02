{
  programs.mpv = {
    config = {
      fullscreen = true;
      no-keepaspect-window = "";
      save-position-on-quit = "";
      no-window-dragging = "";

      ytdl-format = "bestvideo[height<=?1080]+bestaudio/best";
      ytdl-raw-options = "format-sort=\"proto:m3u8\",mark-watched=,cookies-from-browser=\"firefox\",user-agent=\"Mozilla/5.0\"";

      audio-device = "pipewire";
    };
    defaultProfiles = ["best"];
  };
}
