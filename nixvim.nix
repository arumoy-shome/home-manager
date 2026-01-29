{ lib, pkgs, ... }:

{
  enable = false;
  vimAlias = true;
  clipboard.register = "unnamedplus";
  colorschemes.modus.enable = true;
  opts = {
    expandtab = true;
    shiftwidth = 2;
  };
  # plugins {{{
  plugins = {
    mini.enable = true;
    mini-basics = {
      enable = true;
      settings = {
        options = {
          extra_ui = true;
          win_borders = "bold";
        };
        mappings = {
          option_toggle_prefix = "yo";
        };
        autocommands = {
          relnum_in_visual_mode = true;
        };
      };
    };
    mini-align.enable = true;
    mini-surround.enable = true;
    mini-trailspace.enable = true;
    mini-icons.enable = true;
    mini-indentscope.enable = true;
    mini-statusline.enable = true;
    mini-tabline.enable = true;
    mini-files.enable = true;
    mini-completion.enable = true;
    mini-pick.enable = true;
    treesitter = {
      enable = true;
      highlight.enable = true;
      indent.enable = true;
      folding.enable = true;
    };
    conform-nvim = {
      enable = true;
      settings = {
        formatters_by_ft = {
          tex = [ "tex-fmt" ];
          bib = [ "tex-fmt" ];
          python = [ "ruff_format" "ruff_organize_imports" ];
        };
        format_on_save = {
          lsp_format = "fallback";
          timeout_ms = 500;
        };
      };
    };
    lspconfig.enable = true;
    dap.enable = true;
    dap-python.enable = true;
    dap-view.enable = true;
    vimtex = {
      enable = true;
      settings.compiler_method = "tectonic";
    };
  };
  # }}}
  # keymaps {{{
  keymaps = [
    {
      action = "<cmd>nohlsearch<cr>";
      key = "<Esc>";
      mode = "n";
    }
    {
      action = "<C-\\><C-n>";
      key = "<Esc><Esc>";
      mode = "t";
    }
    {
      action = lib.nixvim.mkRaw "function() MiniFiles.open() end";
      key = "<Leader>e";
      mode = "n";
    }
    {
      action = lib.nixvim.mkRaw "function() MiniPick.builtin.files() end";
      key = "<Leader><Leader>";
      mode = "n";
    }
    {
      action = lib.nixvim.mkRaw "function() MiniPick.builtin.grep() end";
      key = "<Leader>.";
      mode = "n";
    }
  ];
  # }}}
  # lsp {{{
  lsp = {
    keymaps = [
      {
        action = lib.nixvim.mkRaw "function() vim.diagnostic.setloclist() end";
        key = "<Leader>d";
        mode = "n";
      }
    ];
    servers = {
      ty.enable = true;
      marksman.enable = true;
    };
  };
  # }}}
}
