return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.g.catppuccin_flavour = "mocha"
      require("catppuccin").setup()
      vim.cmd.colorscheme("catppuccin")
    end,
    opts = {
      integrations = {
        dropbar = {
          enabled = true,
          color_mode = true,
        },
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        gitsigns = true,
        indent_blankline = {
          enabled = true,
        },
        lsp_trouble = true,
        markdown = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      theme = "catppuccin",
      options = {
        icons_enabled = true,
        component_separators = "",
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(str)
              local alias = {
                n = "N",       -- Normal (NO)
                i = "I",       -- Insert (IN)
                v = "V",       -- Visual (VI)
                V = "L",       -- Visual Line (VL)
                ["\22"] = "B", -- Visual Block (VB)
                c = "C",       -- Command (CO)
                s = "S",       -- Select (SE)
                S = "L",       -- Select Line (SL)
                ["\19"] = "B", -- Select Block (SB)
                R = "R",       -- Replace (RE)
                Rv = "V",      -- Visual Replace (RV)
                t = "T",       -- Terminal (TE)
                nt = "T",      -- Terminal Normal (TN)
                no = "O",      -- Operator-pending (OP)
                r = "P",       -- Prompt (PR)
                rm = "M",      -- More (MO)
                ["r?"] = "F",  -- Confirm (CF)
                cv = "E",      -- Vim Ex (EX)
                ce = "E",      -- Normal Ex (EX)
              }

              local mode_code = vim.api.nvim_get_mode().mode
              return alias[mode_code] or str:upper()
            end,
            icons_enabled = true,
            icon = "",
            padding = 0,
            separator = { left = "", right = "" },
          },
        },
        lualine_b = {
          {
            "branch",
            icon = "",
            padding = { left = 1, right = 0 },
          },
          {
            "diff",
            symbols = {
              added = " ",
              modified = " ",
              removed = " ",
            },
            padding = { left = 1, right = 0 },
          },
          {
            "lsp_status",
            padding = { left = 1, right = 0 },
          },
          {
            "diagnostics",
            padding = { left = 1, right = 0 },
          },
        },
        lualine_c = {
          {
            "filetype",
            icon_only = true,
            padding = { left = 1, right = 0 },
          },
          {
            "filename",
            padding = { left = 1, right = 0 },
          },
        },
        lualine_x = {
          {
            "encoding",
            show_bomb = true,
            padding = { left = 0, right = 1 },
          },
          {
            "fileformat",
            padding = { left = 0, right = 1 },
          },
        },
        lualine_y = {
          {
            "searchcount",
            icon = "",
            padding = { left = 0, right = 1 },
          },
          {
            "selectioncount",
            icon = "󰒉",
            padding = { left = 0, right = 1 },
          },
          {
            "progress",
            padding = { left = 0, right = 1 },
          },
        },
        lualine_z = {
          {
            "location",
            padding = 0,
            separator = { left = "", right = "" },
          },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { "quickfix", "trouble", "lazy", "fzf" },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VimEnter",
    opts = {
      preset = "modern",
      delay = 0,
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
    init = function()
      local wk = require("which-key")
      wk.add({
        { "<leader>w", proxy = "<c-w>", group = "windows" },
      })
    end,
  },
  {
    "NMAC427/guess-indent.nvim",
    lazy = true,
  },
  { "nvim-mini/mini.diff", version = "*", opts = {} },
  {
    "echasnovski/mini.icons",
    version = "*",
    opts = {},
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
  {
    "Bekaboo/dropbar.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    opts = {
      bar = {
        enabled = true,
      },
    },
    config = function()
      local dropbar_api = require("dropbar.api")
      vim.keymap.set("n", "<Leader>;", dropbar_api.pick, {
        desc = "Pick symbols in winbar",
      })
      vim.keymap.set("n", "[;", dropbar_api.goto_context_start, {
        desc = "Go to start of current context",
      })
      vim.keymap.set("n", "];", dropbar_api.select_next_context, {
        desc = "Select next context",
      })
    end,
  },
}
