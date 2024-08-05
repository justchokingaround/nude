{
  config,
  inputs,
  ...
}: let
  inherit (config.colorScheme) palette;
in {
  imports = [inputs.schizofox.homeManagerModule];

  programs.schizofox = {
    enable = true;

    theme = {
      defaultUserChrome.enable = false;
      defaultUserContent.enable = false;

      extraUserChrome = ''
        :root {
          --srf-primary: #${palette.base00};
          --srf-secondary: #${palette.base01};
          --srf-text: #${palette.base04};
          --srf-accent: #${palette.base0C};
        }
        window,
        #main-window,
        #toolbar-menubar,
        #TabsToolbar,
        #PersonalToolbar,
        #navigator-toolbox,
        #sidebar-box {
          background-color: var(--srf-primary) !important;
          -moz-appearance: none !important;
          background-image: none !important;
          border: none !important;
          box-shadow: none !important;
        }
        ::selection {
          background-color: var(--srf-accent);
          color: var(--srf-primary);
        }
        :root {
          --tabs-border: transparent !important;
        }
        .tab-background {
          border: none !important;
          border-radius: 0 !important;
          margin: 0 !important;
          margin-left: -1.6px !important;
          padding: 0 !important;
        }
        .tab-background[selected="true"] {
          -moz-appearance: none !important;
          background-image: none !important;
          background-color: var(--srf-secondary) !important;
        }
        .tabbrowser-tabs {
          border: none !important;
          opacity: 0 !important;
        }
        .tabbrowser-tab::before,
        .tabbrowser-tab::after {
          opacity: 0 !important;
          border-left: none !important;
        }
        .titlebar-placeholder {
          border: none !important;
        }
        .tab-line {
          display: none !important;
        }
        #pageActionButton,
        #urlbar-zoom-button,
        #identity-box,
        #tracking-protection-icon-container {
          display: none !important;
        }
        #context-savepage,
        #context-sendpagetodevice,
        #context-sendlinktodevice,
        #context-savelink,
        #context-savelinktopocket,
        #context-sendlinktodevice,
        #context-print-selection,
        #context_bookmarkTab,
        #context_sendTabToDevice,
        #context_closeTabOptions {
          display: none !important;
        }
        .titlebar-spacer {
          display: none !important;
        }
        .tabbrowser-tab:not([pinned]) .tab-close-button {
          display: none !important;
        }
        .tabbrowser-tab:not([pinned]) .tab-icon-image {
          display: none !important;
        }
        #navigator-toolbox::after {
          border-bottom: 0px !important;
          border-top: 0px !important;
        }
        #nav-bar {
          background: var(--srf-secondary) !important;
          border: none !important;
          box-shadow: none !important;
          margin-top: 0px !important;
          border-top-width: 0px !important;
          margin-bottom: 0px !important;
          border-bottom-width: 0px !important;
        }
        #history-panel,
        #sidebar-search-container,
        #bookmarksPanel {
          background: var(--srf-primary) !important;
        }
        #search-box {
          -moz-appearance: none !important;
          background: var(--srf-primary) !important;
          border-radius: 6px !important;
        }
        #sidebar-search-container {
          background-color: var(--srf-primary) !important;
        }
        #sidebar-icon {
          display: none !important;
        }
        .sidebar-placesTree {
          color: var(--srf-text) !important;
        }
        #sidebar-switcher-target {
          color: var(--srf-text) !important;
        }
        #sidebar-header {
          background: var(--srf-primary) !important;
        }
        #sidebar-box {
          --sidebar-background-color: var(--srf-primary) !important;
        }
        #sidebar-splitter {
          border: none !important;
          opacity: 1 !important;
          background-color: var(--srf-primary) !important;
        }
        .urlbarView {
          display: none !important;
        }
        #urlbar-input-container {
          background-color: var(--srf-secondary) !important;
          border: 1px solid rgba(0, 0, 0, 0) !important;
        }
        #urlbar-container {
          margin-left: 8px !important;
        }
        #urlbar[focused="true"] > #urlbar-background {
          box-shadow: none !important;
        }
        .urlbarView-url {
          color: var(--srf-text) !important;
        }
      '';

      extraUserContent = ''
        :root {
          scrollbar-width: none !important;
        }
        @-moz-document url(about:privatebrowsing) {
          :root {
            scrollbar-width: none !important;
          }
        }
         @-moz-document url("about:newtab"), url("about:home") {
          body {
            background-color: #${palette.base01} !important;
          }
          .search-wrapper .logo-and-wordmark .logo {
            background-image: url("https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nixos-white.png") !important;
            background-size: 100% !important;
            height: 250px !important;
            width: 500px !important;
          }
          .icon-settings,
          .body-wrapper,
          .SnippetBaseContainer,
          .search-handoff-button,
          .search-wrapper .logo-and-wordmark .wordmark,
          .search-wrapper .search-inner-wrapper,
          .search-wrapper input {
            display: none !important;
          }
        }
      '';
    };

    search = {
      defaultSearchEngine = "Perplexity";
      removeEngines = ["Bing" "Amazon.com" "eBay" "Twitter" "Wikipedia"];
      addEngines = [
        {
          Name = "SearXNG";
          Description = "SearXNG";
          Method = "GET";
          URLTemplate = "https://search.notashelf.dev/search?q={searchTerms}";
        }
        {
          Name = "Startpage";
          Description = "Startpage";
          Method = "GET";
          URLTemplate = "https://www.startpage.com/sp/search?query={searchTerms}";
        }
        {
          Name = "Yandex";
          Description = "Yandex";
          Alias = "!y";
          Method = "GET";
          URLTemplate = "https://ya.ru/search/?text={searchTerms}";
        }
        {
          Name = "Google";
          Description = "Google";
          Alias = "!go";
          Method = "GET";
          URLTemplate = "https://www.google.com/search?q={searchTerms}";
        }
        {
          Name = "Perplexity";
          Description = "Perplexity";
          Alias = "!pe";
          Method = "GET";
          URLTemplate = "https://www.perplexity.ai/search?q={searchTerms}";
        }
        {
          Name = "NixOS Packages";
          Description = "NixOS Unstable package search";
          Alias = "!np";
          Method = "GET";
          URLTemplate = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}";
        }
        {
          Name = "NixOS Options";
          Description = "NixOS Unstable option search";
          Alias = "!no";
          Method = "GET";
          URLTemplate = "https://search.nixos.org/options?channel=unstable&query={searchTerms}";
        }
        {
          Name = "NixOS Wiki";
          Description = "NixOS Wiki search";
          Alias = "!nw";
          Method = "GET";
          URLTemplate = "https://nixos.wiki/index.php?search={searchTerms}";
        }
        {
          Name = "Home Manager Options";
          Description = "Home Manager option search";
          Alias = "!hm";
          Method = "GET";
          URLTemplate = "https://mipmip.github.io/home-manager-option-search?query={searchTerms}";
        }
        {
          Name = "noogle";
          Descriptiom = "Noogle Search";
          Alias = "!no";
          Method = "GET";
          URLTemplate = "https://noogle.dev/";
        }
        {
          Name = "Anna's Archive";
          Description = "The largest truly open library in human history.";
          Alias = "!anna";
          Method = "GET";
          URLTemplate = "https://annas-archive.org/search?q={searchTerms}";
        }
      ];
    };

    security = {
      sanitizeOnShutdown = false;
      noSessionRestore = true;
    };

    misc = {
      drmFix = true;
      disableWebgl = false;
      bookmarks = [
        {
          Title = "Nyx";
          URL = "https://github.com/NotAShelf/nyx";
          Placement = "toolbar";
          Folder = "Github";
        }
        {
          Title = "Standard Library";
          URL = "https://doc.rust-lang.org/std";
          Placement = "toolbar";
          Folder = "Rust";
        }
        {
          Title = "Crate Search";
          URL = "https://crates.io/";
          Placement = "toolbar";
          Folder = "Rust";
        }
        {
          Title = "Rust by Example";
          URL = "https://doc.rust-lang.org/stable/rust-by-example/";
          Placement = "toolbar";
          Folder = "Rust";
        }
        {
          Title = "Rust Reference";
          URL = "https://doc.rust-lang.org/stable/reference/";
          Placement = "toolbar";
          Folder = "Rust";
        }
        {
          Title = "Rustonomicon";
          URL = "https://doc.rust-lang.org/nomicon/";
          Placement = "toolbar";
          Folder = "Rust";
        }
      ];
    };

    settings = {
      # smoothfox stuff
      "nglayout.initialpaint.delay" = 0;
      "nglayout.initialpaint.delay_in_oopif" = 0;
      "content.notify.interval" = 100000;
      "browser.startup.preXulSkeltonUI" = false;
      "gfx.webrender.all" = true;
      "gfx.webrender.precache-shaders" = true;
      "gfx.webrender.compositor" = true;
      "gfx.webrender.compositor.force-enabled" = true;
      "media.hardware-video-decoding.enabled" = true;
      "gfx.canvas.accelerated" = true;
      "gfx.canvas.accelerated.cache-items" = true;
      "gfx.canvas.accelerated.cache-size" = 4096;
      "gfx.content.skia-font-cache-size" = 80;
      "layers.gpu-process.enabled" = true;
      "layers.mlgpu.enabled" = true;
      "media.ffmpeg.vaapi.enabled" = true;
      "image.cache.size" = 10485760;
      "image.mem.decode_bytes_at_a_time" = 131072;
      "image.mem.shared.unmap.min_expiration_msn" = 120000;
      "media.memory_cache_max_size" = 1048576;
      "media.memory_caches_combined_limit_kb" = 2560000;
      "media.cache_readahead_limit" = 9000;
      "media.cache_resume_threshold" = 6000;
      "browser.cache.memory.max_entry_size" = 0;
      "network.buffer.cache.size" = 262144;
      "network.buffer.cache.count" = 128;
      "network.http.max-connections" = 1800;
      "network.http.max-persistent-connections-per-server" = 30;
      "network.ssl_tokens_cache_capacity" = 32768;
      "general.smoothScroll.msdPhysics.enabled" = true;
      "layout.frame_rate" = 165;
      "layout.css.backdrop-filter.enabled" = true;

      "general.smoothScroll" = true;
      "browser.ctrlTab.sortByRecentlyUsed" = true;
      "browser.policies.runOncePerModification.displayBookmarksToolbar" = "always";
      "widget.use-xdg-desktop-portal.file-picker" = 1;
      "dom.event.clipboardevents.enabled" = true; # fixes clipboard issues
      "browser.startup.page" = 3; # restore previous session automatically
      "dom.event.contextmenu.enabled" = true; # fixes yt right click
      "privacy.resistFingerprinting" = false;
    };

    extensions = {
      darkreader.enable = true;
      simplefox.enable = false;
      extraExtensions = let
        mkUrl = name: "https://addons.mozilla.org/firefox/downloads/latest/${name}/latest.xpi";
      in {
        "{c2c003ee-bd69-42a2-b0e9-6f34222cb046}".install_url = mkUrl "auto-tab-discard";
        "sponsorBlocker@ajay.app".install_url = mkUrl "sponsorblock";
        "{446900e4-71c2-419f-a6a7-df9c091e268b}".install_url = mkUrl "bitwarden-password-manager";
        "{036a55b4-5e72-4d05-a06c-cba2dfcc134a}".install_url = mkUrl "traduzir-paginas-web";
        "idcac-pub@guus.ninja".install_url = mkUrl "istilldontcareaboutcookies";
        "{96ef5869-e3ba-4d21-b86e-21b163096400}".install_url = mkUrl "font-fingerprint-defender";
        "{762f9885-5a13-4abd-9c77-433dcd38b8fd}".install_url = mkUrl "return-youtube-dislikes";
        "vimium-c@gdh1995.cn".install_url = mkUrl "vimium-c";
        # "firenvim@lacamb.re".install_url = mkUrl "firenvim";
        "youtube-enhancer@VampireChicken".install_url = mkUrl "youtube-enhancer-vc";
        "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}".install_url = mkUrl "refined-github-";
        "1018e4d6-728f-4b20-ad56-37578a4de76".install_url = mkUrl "flagfox";
        # "falling-metal-pipe@swantzter.com".install_url = mkUrl "falling-metal-pipe";
      };
    };
  };
}
