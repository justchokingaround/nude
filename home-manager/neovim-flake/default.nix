{
  config,
  inputs,
  pkgs,
  lib,
  ...
}: let
  inherit (builtins) filter map toString;
  inherit (lib.filesystem) listFilesRecursive;
  inherit (lib.strings) hasSuffix fileContents removeSuffix;
  inherit (lib.attrsets) genAttrs;
  nvf = inputs.neovim-flake;
in {
  imports = [inputs.neovim-flake.homeManagerModules.default];
  # imports = [inputs.neovim-flake.${pkgs.hostPlatform.system}.maximal];

  programs.neovim-flake = {
    enable = true;
    settings = {
      vim = {
        viAlias = false;
        vimAlias = false;
        lineNumberMode = "none";
        package = pkgs.neovim-unwrapped;
        extraPlugins = with pkgs.vimPlugins; {
          harpoon = {package = harpoon;};
          luasnip = {package = luasnip;};
          markdown-preview-nvim = {package = markdown-preview-nvim;};
          smart-splits-nvim = {package = smart-splits-nvim;};
          dressing-nvim = {package = dressing-nvim;};
          firenvim = {package = firenvim;};
          codeium-vim = {package = codeium-vim;};
          octo-nvim = {package = octo-nvim;};
          vim-test = {package = vim-test;};
          vimux = {package = vimux;};
          vimtex = {package = vimtex;};
        };
        maps = {
          normal = {
            # Diffview
            "<leader>gdq".action = ":DiffviewClose<CR>";
            "<leader>gdd".action = ":DiffviewOpen<CR>";
            "<leader>gdm".action = ":DiffviewOpen<CR>";
            "<leader>gdh".action = ":DiffviewFileHistory %<CR>";
            "<leader>gde".action = ":DiffviewToggleFiles<CR>";

            # ToggleTerm
            "<A-i>".action = ":ToggleTerm direction=float<CR>";

            # Telescope
            "<leader>ff".action = ":Telescope find_files<CR>";
            "<leader>fr".action = ":Telescope oldfiles<CR>";
            "<leader>fq".action = ":Telescope quickfix<CR>";
            "<leader>f/".action = ":Telescope live_grep<cr>";
            "<leader>/".action = ":Telescope current_buffer_fuzzy_find<CR>";
            "<C-b>".action = ":Telescope buffers<CR>";
            "<leader>p".action = ":Telescope projects<CR>";

            # Git
            "<leader>gu".action = "<cmd>Gitsigns undo_stage_hunk<CR>";
            "<leader>g<C-w>".action = "<cmd>Gitsigns preview_hunk<CR>";
            "<leader>gp".action = "<cmd>Gitsigns prev_hunk<CR>";
            "<leader>gn".action = "<cmd>Gitsigns next_hunk<CR>";
            "<leader>gP".action = "<cmd>Gitsigns preview_hunk_inline<CR>";
            "<leader>gR".action = "<cmd>Gitsigns reset_buffer<CR>";
            "<leader>gb".action = "<cmd>Gitsigns blame_line<CR>";
            "<leader>gD".action = "<cmd>Gitsigns diffthis HEAD<CR>";
            "<leader>gw".action = "<cmd>Gitsigns toggle_word_diff<CR>";
            "<leader>go".action = "<cmd>Octo actions<CR>";

            # Smart splits
            "<A-h>".action = ":lua require('smart-splits').resize_left()<CR>";
            "<A-j>".action = ":lua require('smart-splits').resize_down()<CR>";
            "<A-k>".action = ":lua require('smart-splits').resize_up()<CR>";
            "<A-l>".action = ":lua require('smart-splits').resize_right()<CR>";
            "<C-h>".action = ":lua require('smart-splits').move_cursor_left()<CR>";
            "<C-j>".action = ":lua require('smart-splits').move_cursor_down()<CR>";
            "<C-k>".action = ":lua require('smart-splits').move_cursor_up()<CR>";
            "<C-l>".action = ":lua require('smart-splits').move_cursor_right()<CR>";

            # QOL
            "<Esc>".action = ":noh<CR>";
            "<leader>bd".action = ":bd<CR>";
            "<C-c>".action = ":%y+<CR>";
            "<Tab>".action = ":BufferLineCycleNext<CR>";
            "<S-Tab>".action = ":BufferLineCyclePrev<CR>";
            "K".action = ":lua vim.lsp.buf.hover()<CR>";

            # Vim-test
            ",tf".action = ":TestFile<CR>";
            ",ts".action = ":TestSuite<CR>";
            ",tl".action = ":TestLast<CR>";
            ",tv".action = ":TestVisit<CR>";
            ",tn".action = ":TestNearest<CR>";

            # Hop
            "<leader>w".action = ":HopWord<CR>";
            "s".action = ":HopChar1<CR>";
            "<leader>j".action = ":HopLine<CR>";
            "<leader>k".action = ":HopLine<CR>";
            "n".action = "nzzzv";
            "N".action = "Nzzzv";

            # Save
            "<C-s>".action = ":w<CR>";
          };

          visual = {
            "<".action = "<gv";
            ">".action = ">gv";
            "<A-i>".action = ":ToggleTerm<CR>";
            "J".action = ":m '>+1<CR>gv=gv";
            "K".action = ":m '<-2<CR>gv=gv";
            "p".action = "\"_dP";
          };

          insert = {
            "<A-i>".action = "<Esc>:ToggleTerm<CR>";
            "<C-s>".action = "<Esc>:w<CR>a";
          };

          terminal = {
            "<A-i>".action = "<cmd>q<CR>";
          };
        };

        enableEditorconfig = true;
        preventJunkFiles = true;
        enableLuaLoader = true;
        useSystemClipboard = true;
        spellChecking.enable = false;
        autoIndent = true;
        dashboard.alpha.enable = true;
        tabline.nvimBufferline.enable = true;

        filetree = {
          nvimTree = {
            enable = true;
            openOnSetup = false;

            mappings = {
              toggle = "<leader>e";
            };

            setupOpts = {
              disable_netrw = true;
              update_focused_file.enable = true;

              hijack_unnamed_buffer_when_opening = true;
              hijack_cursor = true;
              hijack_directories = {
                enable = true;
                auto_open = true;
              };

              git = {
                enable = true;
                show_on_dirs = false;
                timeout = 500;
              };

              view = {
                cursorline = false;
                width = 35;
              };

              renderer = {
                indent_markers.enable = true;
                root_folder_label = false; # inconsistent

                icons = {
                  modified_placement = "after";
                  git_placement = "after";
                  show.git = true;
                  show.modified = true;
                };
              };

              diagnostics.enable = true;

              modified = {
                enable = true;
                show_on_dirs = false;
                show_on_open_dirs = true;
              };

              actions = {
                change_dir.enable = false;
                change_dir.global = false;
                open_file.window_picker.enable = true;
              };
            };
          };
        };

        ui = {
          borders = {
            enable = true;
            globalStyle = "rounded";
          };
          colorizer.enable = true;
        };

        theme = {
          enable = true;
          name = "oxocarbon";
          style = "dark";
          transparent = false;
        };

        presence.neocord = {
          enable = false;
          logo_tooltip = "The Superior Text Editor";
          # client_id = "793271441293967371";
          client_id = "1226192546120732815";
          # main_image = "logo";
          main_image = "language";
          show_time = true;
        };

        debugMode = {
          enable = false;
          logFile = "/tmp/nvim.log";
        };

        visuals = {
          enable = true;
          nvimWebDevicons.enable = true;
          fidget-nvim.enable = true;
          indentBlankline = {
            enable = true;
            fillChar = null;
            eolChar = null;
            scope = {enabled = true;};
          };
        };

        comments = {comment-nvim.enable = true;};

        telescope = {
          enable = true;
          mappings = {
            liveGrep = "<C-f>";
            findFiles = "<leader><leader>";
          };
        };
        projects = {
          project-nvim = {
            enable = true;
            manualMode = false;
            detectionMethods = ["lsp" "pattern"];
            patterns = [
              ".git"
              ".hg"
              "Makefile"
              "package.json"
              "index.*"
              ".anchor"
              "flake.nix"
            ];
          };
        };

        binds = {
          whichKey.enable = true;
          cheatsheet.enable = true;
        };

        autopairs.enable = true;
        autocomplete = {
          enable = true;
          type = "nvim-cmp";
        };

        utility = {
          ccc.enable = true;
          surround.enable = true;
          diffview-nvim.enable = true;
          motion = {
            hop.enable = true;
          };
        };

        notes = {
          todo-comments.enable = true;
          obsidian.enable = true;
        };

        terminal = {
          toggleterm = {
            enable = true;
            lazygit.enable = true;
          };
        };

        git = {
          enable = true;
          gitsigns.enable = true;
        };

        statusline = {
          lualine = {
            enable = true;
            theme = "oxocarbon";
          };
        };

        lsp = {
          formatOnSave = true;
          lspkind.enable = false;
          lspconfig.enable = true;
          lightbulb.enable = false;
          lspsaga.enable = false;
          nvimCodeActionMenu.enable = true;
          trouble.enable = true;
          lspSignature.enable = true;
          lsplines.enable = true;
          nvim-docs-view.enable = true;
          null-ls.enable = true;
        };
        debugger.nvim-dap = {
          enable = false;
          ui.enable = false;
        };

        languages = {
          enableDAP = false;
          enableLSP = true;
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;
          nix.enable = true;
          html.enable = true;
          css.enable = true;
          ts.enable = true;
          ts.extraDiagnostics.enable = false;
          svelte.enable = true;
          go.enable = true;
          zig.enable = true;
          python.enable = true;
          dart.enable = true;

          bash = {
            enable = true;
            format.enable = true; # FIXME: custom shfmt flags
          };
          markdown.enable = true;
          tailwind.enable = true;
          lua = {
            enable = true;
            lsp.neodev.enable = true;
          };
          clang = {
            enable = true;
            lsp.server = "clangd";
          };
          rust = {
            enable = true;
            crates.enable = true;
          };
          java = let
            jdtlsCache = "${config.xdg.cacheHome}/jdtls";
          in {
            enable = true;
            lsp.package = [
              "${lib.getExe pkgs.jdt-language-server}"
              "-configuration ${jdtlsCache}/config"
              "-data ${jdtlsCache}/workspace"
            ];
          };
        };
        treesitter = {
          enable = true;
          context = {
            enable = false;
            maxLines = 1;
          };
          fold = true;
        };

        assistant = {
          copilot = {
            enable = false;
            cmp.enable = false;
          };
        };

        luaConfigRC = let
          inherit (nvf.lib.nvim.dag) entryAnywhere;

          # get the name of each lua file in the lua directory, where setting files reside
          configPaths =
            map (f: removeSuffix ".lua" f)
            (filter (hasSuffix ".lua")
              (map toString (listFilesRecursive ./lua)));

          # get the path of each file by removing the ./. prefix from each element in the list
          configNames = map (p: removeSuffix "./" p) configPaths;

          # generates a key-value pair that looks roughly as follows:
          # "fileName" = entryAnywhere "<contents of ./lua/fileName.lua>"
          # which is expected by neovim-flake's modified DAG library
          luaConfig = genAttrs configNames (name:
            entryAnywhere ''
              ${fileContents "${name}.lua"}
            '');
        in
          luaConfig;
      };
    };
  };
}
