{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.nixvim.homeManagerModules.nixvim];
  programs = {
    nixvim = {
      enable = true;
      luaLoader.enable = true;
      colorschemes.oxocarbon.enable = true;
      extraConfigLuaPre = ''
        local tele = require("telescope.actions")
        vim.api.nvim_set_hl(0, 'Comment', { italic=true })
      '';
      extraConfigLuaPost = ''
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        local cmp = require('cmp')
        cmp.event:on(
          'confirm_done',
          cmp_autopairs.on_confirm_done())
      '';
      globals = {
        mapleader = " ";
        neovide_cursor_animation_length = 0.025;
        neovide_refresh_rate = 75;
        neovide_input_ime = true;
        neovide_padding_bottom = 8;
        neovide_padding_top = 8;
        neovide_padding_right = 8;
        neovide_padding_left = 8;
        neovide_transparency = 0.90;
      };
      clipboard.providers.wl-copy.enable = true;
      enableMan = false;
      opts = {
        number = true;
        relativenumber = false;
        completeopt = "menu,menuone,noselect";
        shiftwidth = 2;
        tabstop = 2;
        confirm = true;
        grepformat = "%f:%l:%c:%m";
        grepprg = "rg --vimgrep";
        expandtab = true;
        autoindent = true;
        laststatus = 3;
        autoread = true;
        history = 10000;
        timeoutlen = 200;
        cindent = true;
        wrap = false;
        ignorecase = true;
        autochdir = true;
        smarttab = true;
        listchars = {
          tab = " ──";
          trail = "·";
          nbsp = "␣";
          precedes = "«";
          extends = "»";
        };
        fillchars = {
          eob = " ";
          vert = " ";
          horiz = " ";
          diff = "╱";
          foldclose = "";
          foldopen = "";
          fold = " ";
          msgsep = "─";
        };
        showmode = false;
        wildmode = "longest:full,full";
        mouse = "a";
        smartcase = true;
        smartindent = true;
        winminwidth = 5;
        cursorline = true;
        scrolloff = 999;
        sidescrolloff = 10;
        termguicolors = true;
        background = "dark";
        signcolumn = "yes";
        backspace = "indent,eol,start";
        splitright = true;
        splitbelow = true;
        swapfile = false;
        clipboard = "unnamedplus";
        undofile = true;
        undolevels = 10000;
        list = true;
        formatoptions = "jcroqlnt";
        conceallevel = 0;
        spell = true;
        spelllang = ["en_us"];
        concealcursor = "nc";
        autowrite = true;
        pumheight = 10;
        pumblend = 10;
        shiftround = true;
        updatetime = 200;
        showbreak = "⤷ ";
      };
      extraPlugins = with pkgs.vimPlugins; [satellite-nvim dressing-nvim];
      plugins = {
        nix.enable = true;
        barbar = {
          enable = true;
          autoHide = true;
          focusOnClose = {__raw = "'previous'";};
        };
        presence-nvim = {
          enable = true;
          clientId = "1226192546120732815";
        };
        hop.enable = true;
        nvim-autopairs = {
          enable = true;
          settings.check_ts = true;
        };
        toggleterm = {
          enable = true;
          settings.direction = "float";
        };
        nvim-bqf.enable = true;
        comment.enable = true;
        todo-comments.enable = true;
        project-nvim = {
          enable = true;
          enableTelescope = true;
          showHidden = true;
        };
        barbecue = {
          enable = true;
          leadCustomSection = ''
            function()
            return { { " ", "WinBar" } }
            end,
          '';
        };
        lsp = {
          enable = true;
          preConfig = ''
            local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
            for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end
          '';
          servers = {
            nil_ls.enable = true;
            clojure-lsp.enable = true;
            bashls.enable = true;
            pyright.enable = true;
            ruff-lsp.enable = true;
          };
        };
        gitsigns = {
          enable = true;
          settings = {
            current_line_blame = true;
            linehl = true;
          };
        };
        cursorline.enable = true;
        harpoon.enable = true;
        alpha = {
          enable = true;
          layout = [
            {
              type = "padding";
              val = 4;
            }
            {
              opts = {
                hl = "Type";
                position = "center";
              };
              type = "text";
              val = [
                "⠀⠀⡜⡁⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
                "⠀⠀⢻⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇"
                "⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⣿⡟⠀⢸⣿⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇"
                "⠀⠀⢸⡿⣿⣿⣿⣿⣿⣿⣿⣿⡟⢸⡿⡇⠀⢸⡿⢸⣿⡟⣿⣿⣿⣿⣿⣿⡏⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃"
                "⠀⠀⠀⠁⠈⢿⣿⣿⣿⡯⢬⣼⣁⠀⣧⢧⠀⠠⡇⠝⣿⡇⢻⣿⣿⣿⣿⣿⠃⠸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
                "⠀⠀⠀⠀⠀⠈⣿⣿⣿⡀⣀⣙⠋⠛⠷⣄⠀⢀⡇⠨⢃⣧⠚⠉⠙⣿⠿⠟⠀⢘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
                "⠀⠀⠀⠀⠀⠀⣿⢿⣿⡏⣙⣿⣷⣄⣢⡈⠁⠀⠀⠀⠀⠏⠠⠶⠷⠿⢶⣦⣄⡐⠟⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⡘⠀"
                "⠀⠀⠀⠀⠀⠀⢻⠀⢻⡇⠘⠻⠿⠿⠿⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⣶⣖⡀⠉⠛⠓⠦⣼⣿⠟⣿⣿⣿⣿⣿⣿⣿⠋⡈⣿⣿⣿⡇⠇"
                "⠀⠀⠀⠀⠀⠀⠘⠂⠀⢱⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢈⣿⣿⣷⣶⣤⣀⡀⢻⢓⣿⣿⣿⣿⣿⣿⣯⠞⣼⣿⣿⣿⡧"
                "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠛⠿⠿⠗⠛⠀⠀⠘⣿⣿⣿⣿⣿⡟⣀⣾⣿⣿⣿⠏⣿"
                "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢧⡀⠀⠀⠀⠀⡜⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⣿⣭⣿⣿⣿⣿⣿⣿⡏⠀⠹"
                "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢳⣄⠀⠀⠈⠓⢤⡤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡆⣿⣿⣿⣿⡟⠛⠛⠿⠋⡟"
                "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢧⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣎⣴⣿⣿⣿⣿⣿⣦"
                "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⣿⣦⠀⠀⠀⠉⠀⠀⠀⠀⠀⠀⠀⢀⣀⣤⡶⠟⡡⢼⣿⣿⣿⣿⣯⣿"
                "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡤⢾⣿⣿⣿⡇⠑⢤⣀⠀⠀⠀⢀⡀⢠⣴⡮⠕⢋⡡⠔⠋⠀⣼⣿⣿⣿⣿⠿⢹⡙⢆"
                "⠀⠀⠀⠀⠀⢀⣠⢤⣶⣪⣿⣷⣿⣿⣿⡿⡇⠀⠀⠈⢫⡉⠉⠩⢉⣩⠤⠒⠊⠁⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣶⡀⠑⢄"
                "⠀⠀⢀⡤⠒⣉⣀⣾⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⣠⣾⣿⣿⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣄⠑⣄"
                "⢀⣀⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⣴⣿⣿⣿⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠈⢢⡀"
                "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣼⠙"
                "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠈⠉⢀⣨⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣢"
              ];
            }
            {
              type = "padding";
              val = 4;
            }
            {
              type = "button";
              val = "█";
            }
            {
              opts = {
                hl = "Todo";
                position = "center";
              };
              type = "text";
              val = "let's all love lain";
            }
          ];
        };
        trouble.enable = true;
        direnv.enable = true;
        oil = {
          enable = true;
          settings = {
            keymaps = {
              "H" = "actions.parent";
              "Q" = "actions.close";
              "L" = "actions.select";
            };
            view_options = {
              show_hidden = true;
            };
          };
        };
        cmp-buffer.enable = true;
        diffview.enable = true;
        cmp-spell.enable = true;
        cmp-nvim-lsp.enable = true;
        surround.enable = true;
        lastplace.enable = true;
        better-escape.enable = true;
        lspkind.enable = true;
        friendly-snippets.enable = true;
        lsp-format.enable = true;
        none-ls = {
          enable = true;
          enableLspFormat = true;
          sources = {
            formatting = {alejandra.enable = true;};
            diagnostics = {statix.enable = true;};
          };
        };
        noice = {
          enable = true;
          lsp.override = {
            "cmp.entry.get_documentation" = true;
            "vim.lsp.util.convert_input_to_markdown_lines" = true;
            "vim.lsp.util.stylize_markdown" = true;
          };
          views = {
            cmdline_popup.border.style = "single";
            cmdline_popupmenu.border.style = "single";
          };
          presets = {
            bottom_search = true;
            command_palette = true;
            long_message_to_split = true;
            lsp_doc_border = false;
          };
        };
        neogit = {
          enable = true;
          settings = {
            integrations.diffview = true;
            integrations.telescope = true;
            commit_editor.kind = "floating";
            commit_popup.kind = "floating";
            preview_buffer.kind = "floating";
            popup.kind = "floating";
            log_view.kind = "floating";
            description_editor.kind = "floating";
          };
        };
        lualine = {
          enable = true;
          disabledFiletypes.statusline = ["alpha" "toggleterm" "trouble"];
          sectionSeparators = {
            left = "";
            right = "";
          };
          componentSeparators = {
            left = "";
            right = "";
          };
          sections = {
            lualine_a = [
              {
                name = "mode";
                fmt = ''
                  function()
                  return " "
                  end
                '';
              }
            ];
            lualine_b = [
              {
                name = "branch";
                icon = "";
              }
              {name = "diff";}
              {name = "diagnostics";}
            ];
            lualine_x = [
              {
                name = "encoding";
                icon = "";
                fmt = ''
                  function()
                  local msg = ""
                  local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                  local clients = vim.lsp.get_active_clients()
                  if next(clients) == nil then
                  return msg
                  end
                  for _, client in ipairs(clients) do
                  local filetypes = client.config.filetypes
                  if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                  msg = msg .. client.name .. " "
                  end
                  end
                  return msg:sub(1,-2)
                  end
                '';
              }
              {name = "filetype";}
            ];
          };
        };
        luasnip.enable = true;
        cmp_luasnip.enable = true;
        which-key = {
          enable = true;
          registrations = {
            "<leader>f" = "FILES";
            "<leader>l" = "LSP";
            "<leader>g" = "GIT";
            "<leader>w" = "WINDOW";
            "<leader>r" = "SNIPRUN";
            "<leader>j" = "HARPOON";
          };
        };
        spider = {
          enable = true;
          keymaps.motions = {
            b = "b";
            e = "e";
            ge = "ge";
            w = "w";
          };
        };
        treesitter = {
          enable = true;
          incrementalSelection = {
            enable = true;
            keymaps = {
              initSelection = "<C-SPACE>";
              nodeIncremental = "<C-SPACE>";
              nodeDecremental = "<BS>";
            };
          };
        };
        treesitter-textobjects = {
          enable = true;
          lspInterop = {
            enable = true;
            peekDefinitionCode = {
              "<leader>ld" = {
                query = "@function.outer";
                desc = "Hover [d]efinition";
              };
            };
          };
          select = {
            enable = true;
            lookahead = true;
            keymaps = {
              "a=" = {
                query = "@assignment.outer";
                desc = "Select outer part of an assignment";
              };
              "i=" = {
                query = "@assignment.outer";
                desc = "Select outer part of an assignment";
              };
              "l=" = {
                query = "@assignment.lhs";
                desc = "Select left hand side of an assignment";
              };
              "r=" = {
                query = "@assignment.rhs";
                desc = "Select right hand side of an assignment";
              };
              "ai" = {
                query = "@conditional.outer";
                desc = "Select outer part of a conditional";
              };
              "ii" = {
                query = "@conditional.inner";
                desc = "Select inner part of a conditional";
              };
              "il" = {
                query = "@loop.inner";
                desc = "Select inner part of a loop";
              };
              "al" = {
                query = "@loop.outer";
                desc = "Select outer part of a loop";
              };
              "aa" = {
                query = "@parameter.outer";
                desc = "Select outer part of a parameter";
              };
              "ia" = {
                query = "@parameter.inner";
                desc = "Select inner part of a parameter";
              };
              "af" = {
                query = "@function.outer";
                desc = "Select outer part of a function";
              };
              "if" = {
                query = "@function.inner";
                desc = "Select inner part of a function";
              };
              "am" = {
                query = "@call.outer";
                desc = "Select outer part of a method";
              };
              "im" = {
                query = "@call.inner";
                desc = "Select inner part of a method";
              };
            };
          };
          swap = {
            enable = true;
            swapNext = {
              "<leader>af" = "@function.outer";
            };
            swapPrevious = {
              "<leader>bf" = "@function.outer";
            };
          };
          move = {
            enable = true;
            setJumps = true;
            gotoNextStart = {
              "]f" = {
                query = "@function.outer";
                desc = "Next function call start";
              };
              "]m" = {
                query = "@call.outer";
                desc = "Next method call start";
              };
              "]l" = {
                query = "@loop.outer";
                desc = "Next loop start";
              };
              "]i" = {
                query = "@conditional.outer";
                desc = "Next conditional start";
              };
            };
            gotoPreviousStart = {
              "[f" = {
                query = "@function.outer";
                desc = "Previous function call start";
              };
              "[m" = {
                query = "@call.outer";
                desc = "Previous method call start";
              };
              "[l" = {
                query = "@loop.outer";
                desc = "Previous loop start";
              };
              "[i" = {
                query = "@conditional.outer";
                desc = "Previous conditional start";
              };
            };
            gotoPreviousEnd = {
              "[F" = {
                query = "@function.outer";
                desc = "Previous function call end";
              };
              "[M" = {
                query = "@call.outer";
                desc = "Previous method call end";
              };
              "[L" = {
                query = "@loop.outer";
                desc = "Previous loop end";
              };
              "[I" = {
                query = "@conditional.outer";
                desc = "Previous conditional end";
              };
            };
            gotoNextEnd = {
              "]M" = {
                query = "@call.outer";
                desc = "Next method call end";
              };
              "]F" = {
                query = "@function.outer";
                desc = "Next function call end";
              };
              "]L" = {
                query = "@loop.outer";
                desc = "Next loop end";
              };
              "]I" = {
                query = "@conditional.outer";
                desc = "Next conditional end";
              };
            };
          };
        };
        rainbow-delimiters.enable = true;
        sniprun.enable = true;
        cmp = {
          enable = true;
          settings = {
            sources = [
              {
                name = "nvim_lsp";
                keyword_length = 2;
              }
              {
                name = "luasnip";
                keyword_length = 1;
              }
              {
                name = "spell";
                keyword_length = 4;
              }
              {
                name = "path";
                keyword_length = 3;
              }
              {
                name = "buffer";
                keyword_length = 3;
              }
            ];
            matching.disallow_fullfuzzy_matching = true;
            snippet.expand = ''
              function(args)
              require('luasnip').lsp_expand(args.body)
              end
            '';
            mapping = {
              "<C-Space>" = "cmp.mapping.complete()";
              "<C-d>" = "cmp.mapping.scroll_docs(-4)";
              "<C-f>" = "cmp.mapping.scroll_docs(4)";
              "<C-h>" = "cmp.mapping.close()";
              "<CR>" = "cmp.mapping.confirm({ select = true })";
              "<C-l>" = "cmp.mapping.confirm({ select = true })";
              "<C-k>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
              "<C-p>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
              "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
              "<C-j>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
              "<C-n>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
              "<TAB>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            };
          };
        };

        telescope = {
          enable = true;
          extensions.frecency.enable = true;
          settings = {
            defaults = {
              mappings = {
                i = {
                  "<C-j>" = {
                    __raw = "tele.move_selection_next";
                  };
                  "<C-h>" = {
                    __raw = "tele.close";
                  };
                  "<C-l>" = {
                    __raw = "tele.select_default";
                  };
                  "<C-k>" = {
                    __raw = "tele.move_selection_previous";
                  };
                };
              };
            };
          };
        };
      };
      keymaps = [
        {
          key = "<leader>fo";
          mode = "n";
          action = "<CMD>Telescope<CR>";
          options.desc = "[O]pen Telescope";
        }
        {
          key = "<leader>lw";
          mode = "n";
          action = "<CMD>Telescope lsp_workspace_symbols<CR>";
          options.desc = "[W]orkspace symbols";
        }
        {
          key = "<leader>ls";
          mode = "n";
          action = "<CMD>Telescope lsp_document_symbols<CR>";
          options.desc = "Document [s]ymbols";
        }
        {
          key = "<leader>la";
          mode = "n";
          action = "<CMD>lua vim.lsp.buf.code_action()<CR>";
          options.desc = "Show code [a]ctions";
        }
        {
          key = "<leader>lr";
          mode = "n";
          action = "<CMD>lua vim.lsp.buf.rename()<CR>";
          options.desc = "[R]ename symbol";
        }
        {
          key = "<leader>lg";
          mode = "n";
          action = "<CMD>TroubleToggle<CR>";
          options.desc = "Trouble to[g]gle";
        }
        {
          key = "<leader>lt";
          mode = "n";
          action = "<CMD>Telescope lsp_type_definitions<CR>";
          options.desc = "Show [t]ype definitions";
        }
        {
          key = "<leader>lh";
          mode = "n";
          action = "<CMD>lua vim.lsp.buf.signature_help()<CR>";
          options.desc = "Show signature [h]elp";
        }
        {
          key = "K";
          mode = "n";
          action = "<CMD>lua vim.lsp.buf.hover()<CR>";
          options.desc = "Show hover docs";
        }
        {
          key = "[d";
          mode = "n";
          action = "<CMD>lua vim.diagnostic.goto_prev()<CR>";
          options.desc = "Goto prev diagnostic";
        }
        {
          key = "]d";
          mode = "n";
          action = "<CMD>lua vim.diagnostic.goto_next()<CR>";
          options.desc = "Goto next diagnostic";
        }
        {
          key = "<leader>li";
          mode = "n";
          action = "<CMD>Telescope lsp_implementations<CR>";
          options.desc = "Goto [i]mplementations";
        }
        {
          key = "<leader>lD";
          mode = "n";
          action = "<CMD>Telescope lsp_definitions<CR>";
          options.desc = "Goto [d]efinitions";
        }
        {
          key = "<leader>le";
          mode = "n";
          action = "<CMD>Telescope lsp_references<CR>";
          options.desc = "List r[e]ferences";
        }
        {
          key = "<C-j>";
          mode = "i";
          action = "<ESC><CMD>m .+1<cr>==gi";
          options.desc = "Move down";
        }
        {
          key = "<C-k>";
          mode = "i";
          action = "<ESC><CMD>m .-2<cr>==gi";
          options.desc = "Move up";
        }
        {
          key = "K";
          mode = ["x" "v"];
          action = ":move '<-2<CR>gv=gv";
          options.desc = "Move up";
        }
        {
          key = "==";
          mode = "n";
          action = "gg<S-v>G";
          options.desc = "Select all";
        }
        {
          key = "<";
          mode = "v";
          action = "<gv";
        }
        {
          key = ">";
          mode = "v";
          action = ">gv";
        }
        {
          key = "N";
          mode = ["n" "x" "o"];
          action = "Nzzzv";
        }
        {
          key = "n";
          mode = ["n" "x" "o"];
          action = "nzzzv";
        }
        {
          key = "<C-u>";
          mode = ["n" "x" "o"];
          action = "<C-u>zz";
        }
        {
          key = "<C-d>";
          mode = "n";
          action = "<C-d>zz";
        }
        {
          key = "p";
          mode = "v";
          action = "P";
        }
        {
          key = "<Up>";
          mode = ["n" "x"];
          action = "v:count == 0 ? 'gk' : 'k'";
          options = {expr = true;};
        }
        {
          key = "<Down>";
          mode = ["n" "x"];
          action = "v:count == 0 ? 'gj' : 'j'";
          options = {expr = true;};
        }
        {
          key = "k";
          mode = ["n" "x"];
          action = "v:count == 0 ? 'gk' : 'k'";
          options = {expr = true;};
        }
        {
          key = "j";
          mode = ["n" "x"];
          action = "v:count == 0 ? 'gj' : 'j'";
          options = {expr = true;};
        }
        {
          key = "J";
          mode = ["x" "v"];
          options.desc = "Move down";
          action = ":move '>+1<CR>gv=gv";
        }
        {
          key = "<leader>fc";
          mode = "n";
          action = "<CMD>Telescope grep_string<CR>";
          options.desc = "Find string under [c]ursor";
        }
        {
          key = "<leader>fg";
          mode = "n";
          action = "<CMD>Telescope live_grep<CR>";
          options.desc = "Live [g]rep";
        }
        {
          key = "<leader>fe";
          mode = "n";
          action = "<CMD>Telescope frecency<CR>";
          options.desc = "Fr[e]cency files";
        }
        {
          key = "<leader>fr";
          mode = "n";
          action = "<CMD>Telescope oldfiles<CR>";
          options.desc = "[R]ecent files";
        }
        {
          key = "<leader>fu";
          mode = "n";
          action = "<CMD>Telescope colorscheme<CR>";
          options.desc = "Change colorscheme";
        }
        {
          key = "<leader>pf";
          mode = "n";
          action = "<CMD>Telescope git_files<CR>";
          options.desc = "Find [f]ile in project";
        }
        {
          key = "<leader>pp";
          mode = "n";
          action = "<CMD>Telescope projects<CR>";
          options.desc = "Find [p]rojects";
        }
        {
          key = "<leader>ff";
          mode = "n";
          action = "<CMD>Telescope fd<CR>";
          options.desc = "Find [f]iles";
        }
        {
          key = "<leader>fn";
          mode = "n";
          action = "<CMD>ene<CR>";
          options.desc = "[N]ew file";
        }
        {
          key = "<leader>o";
          mode = "n";
          action = "<CMD>lua require('oil').toggle_float()<CR>";
          options.desc = "Open [o]il";
        }
        {
          key = "<leader>t";
          mode = ["n" "t"];
          action = "<CMD>2ToggleTerm direction=tab name=tab <CR>";
          options.desc = "Open terminal as [t]ab";
        }
        {
          key = "<leader>n";
          mode = ["n" "t"];
          action = "<CMD>1ToggleTerm direction=float name=はい <CR>";
          options.desc = "Open termi[n]al";
        }
        {
          key = "]g";
          mode = "n";
          action = "<CMD>Gitsigns prev_hunk<CR>";
          options.desc = "Previous Git hunk";
        }
        {
          key = "[g";
          mode = "n";
          action = "<CMD>Gitsigns next_hunk<CR>";
          options.desc = "Next Git hunk";
        }
        {
          key = "<leader>gg";
          mode = "n";
          action = "<CMD>Neogit<CR>";
          options.desc = "Open Neo[g]it";
        }
        {
          key = "<leader>gd";
          mode = "n";
          action = "<CMD>Gitsigns toggle_deleted<CR>";
          options.desc = "Toggle deleted";
        }
        {
          key = "<leader>gS";
          mode = ["v" "n"];
          action = "<CMD>Gitsigns stage_buffer<CR>";
          options.desc = "[S]tage buffer";
        }
        {
          key = "<leader>gs";
          mode = ["v" "n"];
          action = "<CMD>Gitsigns stage_hunk<CR>";
          options.desc = "[S]tage hunk";
        }
        {
          key = "<leader>gu";
          mode = "n";
          action = "<CMD>Gitsigns undo_stage_hunk<CR>";
          options.desc = "[U]nstage hunk";
        }
        {
          key = "<leader>gp";
          mode = "n";
          action = "<CMD>Gitsigns preview_hunk<CR>";
          options.desc = "[P]review hunk";
        }
        {
          key = "<leader>gr";
          mode = "n";
          action = "<CMD>Gitsigns reset_hunk<CR>";
          options.desc = "[R]eset hunk";
        }
        {
          key = "<leader>wv";
          mode = "n";
          action = "<C-w>v";
          options.desc = "Split window [v]ertically";
        }
        {
          key = "[t";
          mode = ["n" "t"];
          action = "<CMD>tabp<CR>";
          options.desc = "Previous tab";
        }
        {
          key = "]t";
          mode = ["n" "t"];
          action = "<CMD>tabn<CR>";
          options.desc = "Next tab";
        }
        {
          key = "<leader>wd";
          mode = ["n" "t"];
          action = "<CMD>tabp<CR>";
          options.desc = "Previous tab";
        }
        {
          key = "<leader>wa";
          mode = ["n" "t"];
          action = "<CMD>tabn<CR>";
          options.desc = "Next tab";
        }
        {
          key = "<leader>wc";
          mode = "n";
          action = "<CMD>close!<CR>";
          options.desc = "Close [c]urrent split";
        }
        {
          key = "<leader>wh";
          mode = "n";
          action = "<C-w>s";
          options.desc = "Split window [h]orizontally";
        }
        {
          key = "<leader>wn";
          mode = "n";
          action = "<CMD>tabnew<CR>";
          options.desc = "Open [n]ew tab";
        }
        {
          key = "<leader>-";
          mode = "n";
          action = "<C-x>";
          options.desc = "Decrement number";
        }
        {
          key = "<leader>+";
          mode = "n";
          action = "<C-a>";
          options.desc = "Increment number";
        }
        {
          key = "<leader>wk";
          mode = "n";
          action = "<CMD>bd!<CR>";
          options.desc = "Close current tab";
        }
        {
          key = "<leader>wb";
          mode = "n";
          action = "<CMD>e #<CR>";
          options.desc = "Switch to other buffer";
        }
        {
          key = "[b";
          mode = "n";
          action = "<CMD>bprevious<CR>";
          options.desc = "Previous buffer";
        }
        {
          key = "]b";
          mode = "n";
          action = "<CMD>bnext<CR>";
          options.desc = "Next buffer";
        }
        {
          key = "<Tab>";
          mode = "n";
          action = "<CMD>bnext<CR>";
          options.desc = "Next buffer";
        }
        {
          key = "]T";
          mode = "n";
          action = "<CMD>lua require('todo-comments').jump_next()<CR>";
          options.desc = "Next TODO";
        }
        {
          key = "[T";
          mode = "n";
          action = "<CMD>lua require('todo-comments').jump_prev()<CR>";
          options.desc = "Prev TODO";
        }
        {
          key = "<leader>rs";
          mode = ["v" "n"];
          action = "<CMD>SnipClose<CR>";
          options.desc = "Close code output";
        }
        {
          key = "<leader>ra";
          mode = "n";
          action = "<CMD>SnipRun<CR>";
          options.desc = "Run code";
        }
        {
          key = "<leader>rr";
          mode = ["n" "v"];
          action = "<CMD>:lua require'sniprun'.run('v')<CR>";
          options.desc = "Run selected code";
        }
        {
          key = "<leader><leader>";
          mode = ["n" "v"];
          action = ":";
          options.desc = "Open cmdline";
        }
        {
          key = "<S-Tab>";
          mode = "n";
          action = "<CMD>bprevious<CR>";
          options.desc = "Previous buffer";
        }
        {
          key = "<ESC>";
          mode = "n";
          action = "<CMD>noh<CR>";
          options.desc = "Clear highlights";
        }
        {
          key = "<leader>K";
          mode = "n";
          action = "<CMD>qa<CR>";
          options.desc = "Quit";
        }
        {
          key = "<leader>s";
          mode = "n";
          action = "<CMD>w<CR>";
          options.desc = "Save Buffer";
        }
        {
          key = "<C-s>";
          mode = ["n" "i"];
          action = "<CMD>w<CR>";
          options.desc = "Save Buffer";
        }
        {
          key = "<C-h>";
          mode = "n";
          action = "<C-w>h";
          options.desc = "Navigate to pane left";
        }
        {
          key = "<C-l>";
          mode = "n";
          action = "<C-w>l";
          options.desc = "Navigate to pane right";
        }
        {
          key = "<C-k>";
          mode = "n";
          action = "<C-w>k";
          options.desc = "Navigate to pane up";
        }
        {
          key = "<C-j>";
          mode = "n";
          action = "<C-w>j";
          options.desc = "Navigate to pane down";
        }
        {
          key = "<C-Right>";
          mode = "n";
          action = "<CMD>vertical resize +2<CR>";
          options.desc = "Resize pane right";
        }
        {
          key = "<C-Left>";
          mode = "n";
          action = "<CMD>vertical resize -2<CR>";
          options.desc = "Resize pane left";
        }
        {
          key = "<C-Up>";
          mode = "n";
          action = "<CMD>resize +2<CR>";
          options.desc = "Resize pane up";
        }
        {
          key = "<C-Down>";
          mode = "n";
          action = "<CMD>resize -2<CR>";
          options.desc = "Resize pane down";
        }
        {
          key = "<C-j>";
          mode = "c";
          action = "<C-n>";
        }
        {
          key = "<C-l>";
          mode = "c";
          action = "<CR>";
        }
        {
          key = "<C-h>";
          mode = "c";
          action = "<ESC>";
        }
        {
          key = "<C-k>";
          mode = "c";
          action = "<C-p>";
        }
        {
          key = "<leader>a";
          mode = "n";
          action = "<CMD>lua require('harpoon.mark').add_file()<CR>";
          options.desc = "Add file to harpoon";
        }
        {
          key = "]q";
          mode = "n";
          action = "<CMD>cnext<CR>";
          options.desc = "Next quickfix";
        }
        {
          key = "[q";
          mode = "n";
          action = "<CMD>cprev<CR>";
          options.desc = "Prev quickfix";
        }
        {
          key = "<C-e>";
          mode = "n";
          action = "<CMD>lua require('harpoon.ui').toggle_quick_menu()<CR>";
          options.desc = "Harpoon menu";
        }
        {
          key = "s";
          mode = "n";
          action = "<CMD>HopChar1<CR>";
          options.desc = "Jump to [p]attern";
        }
        {
          key = "f";
          action.__raw = ''
            function()
              require'hop'.hint_char1({
                direction = require'hop.hint'.HintDirection.AFTER_CURSOR,
                current_line_only = true
              })
            end
          '';
          options.remap = true;
        }
        {
          key = "F";
          action.__raw = ''
            function()
              require'hop'.hint_char1({
                direction = require'hop.hint'.HintDirection.BEFORE_CURSOR,
                current_line_only = true
              })
            end
          '';
          options.remap = true;
        }
        {
          key = "t";
          action.__raw = ''
            function()
              require'hop'.hint_char1({
                direction = require'hop.hint'.HintDirection.AFTER_CURSOR,
                current_line_only = true,
                hint_offset = -1
              })
            end
          '';
          options.remap = true;
        }
        {
          key = "T";
          action.__raw = ''
            function()
              require'hop'.hint_char1({
                direction = require'hop.hint'.HintDirection.BEFORE_CURSOR,
                current_line_only = true,
                hint_offset = 1
              })
            end
          '';
          options.remap = true;
        }
        {
          key = "<leader>aa";
          mode = "n";
          action = "<CMD>HopPatternCurrentLine<CR>";
          options.desc = "Jump to pattern in current line";
        }
        {
          key = "<leader>.";
          mode = ["n" "v"];
          action = "~";
          options.desc = "Change case";
        }
        {
          key = "<C-BS>";
          mode = ["n" "i" "c"];
          action = "<C-w>";
          options.desc = "Ctrl+Backspace to delete word";
        }
      ];
    };
  };
}
