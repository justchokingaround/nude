{config, ...}: {
  programs.mpv = {
    config = {
      osc = false;
      osd-bar = false;
      border = false;
      osd-font = "${config.stylix.fonts.monospace.name}";
      msg-level = "uosc=error";
    };
    scriptOpts.uosc = {
      # Despair, anguish, agony
      # sed -E -e '/^#.*$/d' -e 's/=no/=false/' -e 's/=yes/=true/' -e 's/=(.*)$/="\1"/' -e 's/="([0-9]+(\.[0-9]+|))"$/=\1/' -e 's/="false"$/=false/' -e 's/="true"$/=true/' -e 's/(.+)$/\1;/
      timeline_style = "bar";
      timeline_line_width = 2;
      timeline_size = 40;
      timeline_persistency = "";
      timeline_border = 1;
      timeline_step = 5;
      timeline_cache = true;

      progress = "windowed";
      progress_size = 2;
      progress_line_width = 20;

      controls = "menu,gap,subtitles,<has_many_audio>audio,<has_many_video>video,<has_many_edition>editions,<stream>stream-quality,gap,space,speed,space,shuffle,loop-playlist,loop-file,gap,prev,items,next,gap,fullscreen";
      controls_size = 32;
      controls_margin = 8;
      controls_spacing = 2;
      controls_persistency = "";

      volume = "right";
      volume_size = 40;
      volume_border = 1;
      volume_step = 1;
      volume_persistency = "";

      speed_step = 0.1;
      speed_step_is_factor = false;
      speed_persistency = "";

      menu_item_height = 36;
      menu_min_width = 260;
      menu_padding = 4;
      menu_type_to_search = true;

      top_bar = "no-border";
      top_bar_size = 40;
      top_bar_controls = true;
      top_bar_title = true;
      top_bar_alt_title = "";
      top_bar_alt_title_place = "below";
      top_bar_flash_on = "video,audio";
      top_bar_persistency = "";

      window_border_size = 1;

      autoload = false;
      autoload_types = "video,audio,image";
      shuffle = false;

      scale = 1;
      scale_fullscreen = 1.3;
      font_scale = 1;
      text_border = 1.2;
      border_radius = 4;
      color = "";
      opacity = "";
      refine = "";
      animation_duration = 100;
      click_threshold = 0;
      click_command = "cycle pause; script-binding uosc/flash-pause-indicator";
      flash_duration = 1000;
      proximity_in = 40;
      proximity_out = 120;
      font_bold = false;
      destination_time = "playtime-remaining";
      time_precision = 0;
      buffered_time_threshold = 60;
      autohide = true;
      pause_indicator = "flash";
      stream_quality_options = "4320,2160,1440,1080,720,480,360,240,144";
      video_types = "3g2,3gp,asf,avi,f4v,flv,h264,h265,m2ts,m4v,mkv,mov,mp4,mp4v,mpeg,mpg,ogm,ogv,rm,rmvb,ts,vob,webm,wmv,y4m";
      audio_types = "aac,ac3,aiff,ape,au,cue,dsf,dts,flac,m4a,mid,midi,mka,mp3,mp4a,oga,ogg,opus,spx,tak,tta,wav,weba,wma,wv";
      image_types = "apng,avif,bmp,gif,j2k,jp2,jfif,jpeg,jpg,jxl,mj2,png,svg,tga,tif,tiff,webp";
      subtitle_types = "aqt,ass,gsub,idx,jss,lrc,mks,pgs,pjs,psb,rt,sbv,slt,smi,sub,sup,srt,ssa,ssf,ttxt,txt,usf,vt,vtt";
      default_directory = "~/";
      show_hidden_files = false;
      use_trash = true;
      adjust_osd_margins = true;

      chapter_ranges = "openings:30abf964,endings:30abf964,ads:c54e4e80";
      chapter_range_patterns = "openings:オープニング;endings:エンディング";

      languages = "slang,en";

      disable_elements = "";
    };
  };
}
