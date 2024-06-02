{
  pkgs,
  lib,
  ...
}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;

    extensions = with pkgs.vscode-extensions;
      [
        brettm12345.nixfmt-vscode
        adpyke.codesnap
        github.copilot
        github.copilot-chat
        vscodevim.vim
        tomoki1207.pdf
        esbenp.prettier-vscode
        formulahendry.code-runner
        github.vscode-pull-request-github
        svelte.svelte-vscode
        usernamehw.errorlens
        equinusocio.vsc-material-theme-icons
        rust-lang.rust-analyzer
        christian-kohler.path-intellisense
        golang.go
        timonwong.shellcheck
        bbenoist.nix
        ms-vscode.live-server
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "alice-carbon-theme";
          publisher = "alice-rei";
          version = "1.1.2";
          sha256 = "sha256-HzOGLZiFuwlKT3moB2g4B2pYRnNncUj4b2pwKEALHhs=";
        }
        {
          name = "excalidraw-editor";
          publisher = "pomdtr";
          version = "3.7.3";
          sha256 = "sha256-ORwyFwbKQgspI+uSTAcHqiM3vWQNHaRk2QD/4uRq+do=";
        }
        {
          name = "spacebox-ui";
          publisher = "SpaceBox";
          version = "0.0.61";
          sha256 = "sha256-I04sEn9RduH3Hu8zurRvTgh8zlUeoHZgGHntwnint5U=";
        }
        {
          name = "github-vscode-theme";
          publisher = "GitHub";
          version = "6.3.4";
          sha256 = "sha256-JbI0B7jxt/2pNg/hMjAE5pBBa3LbUdi+GF0iEZUDUDM=";
        }
      ];

    userSettings = {
      # Interface
      # "workbench.colorTheme" = lib.mkForce "Stylix";
      "workbench.colorTheme" = lib.mkForce "GitHub Dark";
      "workbench.iconTheme" = "eq-material-theme-icons";
      "workbench.colorCustomizations" = {
        "sideBar.background" = "#262626";
        "editor.background" = "#161616";
        "activityBar.background" = "#161616";
      };
      "editor.lineNumbers" = "on";
      "editor.minimap.enabled" = false;
      "editor.cursorBlinking" = "solid";
      "editor.cursorSmoothCaretAnimation" = "on";

      # Font
      "editor.fontSize" = 20;
      "editor.fontLigatures" = true;
      "window.zoomLevel" = 1.5;
      "editor.lineHeight" = 1.5;
      "editor.tabSize" = 2;
      "editor.wordWrap" = "on";

      # Terminal
      "terminal.integrated.fontSize" = 20;
      "terminal.integrated.cursorStyle" = "line";
      "terminal.integrated.cursorBlinking" = false;
      "terminal.integrated.defaultProfile.linux" = "zsh";
      "terminal.integrated.shellIntegration.decorationsEnabled" = "never";

      # Prettier
      "prettier.semi" = false;
      "prettier.useTabs" = true;
      "prettier.singleQuote" = true;
      "prettier.trailingComma" = "es5";
      "prettier.printWidth" = 100;

      # Svelte
      "svelte.enable-ts-plugin" = true;

      # Git
      "diffEditor.renderSideBySide" = false;
      "git.autofetch" = true;

      # Coderunner
      "code-runner.runInTerminal" = true;

      # Codesnap
      "codesnap.showWindowControls" = false;
      "codesnap.showLineNumbers" = false;
      "codesnap.shutterAction" = "copy";
      "codesnap.containerPadding" = "0";
      "codesnap.roundedCorners" = false;
      "codesnap.boxShadow" = "none";

      # Respect keyboard mappings
      "keyboard.dispatch" = "keyCode";
      # "workbench.editor.empty.hint" = "hidden";
      # "workbench.activityBar.location" = "hidden";

      "files.autoSave" = "onFocusChange";
      "editor.formatOnSave" = true;
      "[javascript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[nix]"."editor.tabSize" = 2;
      "[rust]" = {
        "editor.defaultFormatter" = "rust-lang.rust-analyzer";
      };
      "security.workspace.trust.enabled" = false;
      "excalidraw.theme" = "dark";
      "github.copilot.editor.enableAutoCompletions" = true;
      "vim.easymotion" = true;
      "vim.incsearch" = true;
      "vim.useSystemClipboard" = true;
      "vim.useCtrlKeys" = true;
      "vim.hlsearch" = true;
      "vim.leader" = "<space>";
      "vim.normalModeKeyBindings" = [
        {
          "before" = ["<C-p>"];
          "commands" = ["workbench.action.quickOpen"];
        }
      ];
    };

    keybindings = [
      {
        "key" = "ctrl+j ctrl+k";
        "command" = "workbench.action.toggleZenMode";
      }
      {
        "key" = "ctrl+j";
        "command" = "selectNextSuggestion";
        "when" = "suggestWidgetMultipleSuggestions && suggestWidgetVisible && textInputFocus";
      }
      {
        "key" = "ctrl+k";
        "command" = "selectPrevSuggestion";
        "when" = "suggestWidgetMultipleSuggestions && suggestWidgetVisible && textInputFocus";
      }
      {
        "key" = "alt-/";
        "command" = "workbench.panel.chat.view.copilot.focus";
        "when" = "editorFocus";
      }
      {
        "key" = "alt-/";
        "command" = "workbench.action.focusActiveEditorGroup";
        "when" = "!editorFocus";
      }
      {
        "key" = "shift+ctrl+i";
        "command" = "inlineChat.start";
        "when" = "inlineChatHasProvider && !editorReadonly";
      }
    ];
  };
}
