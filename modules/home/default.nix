# vim: expandtab sw=2

{ config, pkgs, ... }:

{
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages = [
    pkgs.python314
    pkgs.tectonic
    pkgs.bibtool
    pkgs.quarto
  ];

  home.file = {
    ".bibtoolrsc".source = ../../files/bibtoolrsc;
    ".editorconfig".source = ../../files/editorconfig;
    ".hammerspoon" = {
      source = ../../files/hammerspoon;
      recursive = true;
    };
  };

  home.sessionVariables = {
  };

  home.shell.enableShellIntegration = true; # default: globally enable shell integration for all supported programs

  editorconfig.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.emacs = {
    enable = false;
    extraPackages = epkgs: [ epkgs.vterm ];
  };

  programs.neovide = {
    enable = false;
    settings = {
        font = {
          normal = "Lilex";
          size = 20;
        };
      };
  };

  programs.helix.enable = false;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  programs.vim = {
    enable = false;
    defaultEditor = false;
    plugins = [
      pkgs.vimPlugins.vim-sensible
      pkgs.vimPlugins.vim-rsi
      pkgs.vimPlugins.vim-nix
      pkgs.vimPlugins.vim-git
      pkgs.vimPlugins.vim-markdown
      pkgs.vimPlugins.vim-surround
      pkgs.vimPlugins.vim-endwise
      pkgs.vimPlugins.vim-repeat
      pkgs.vimPlugins.vim-apathy
      pkgs.vimPlugins.vim-unimpaired
      pkgs.vimPlugins.vim-commentary
      pkgs.vimPlugins.vimtex
    ];
    settings = {
      expandtab = true;
      ignorecase = true;
      smartcase = true;
      mouse = "a";
      mousefocus = true;
      number = true;
      relativenumber = true;
      shiftwidth = 2;
    };
  };

  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";
    enableCompletion = true;
    enableVteIntegration = true;
    historySubstringSearch.enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    dirHashes = {
      docs = "$HOME/Documents";
      dl = "$HOME/Downloads";
      notes = "$HOME/Documents/life-admin";
      code = "$HOME/code";
    };

    # NOTE: bug in nix-darwin
    initContent = ''
      if [[ $(uname -m) == 'arm64' ]]
      then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      fi
    '';

    history = {
      append = true;
      extended = true;
      expireDuplicatesFirst = true;
      ignoreAllDups = true;
      saveNoDups = true;
    };

    oh-my-zsh = {
      enable = false;
      theme = "robbyrussell";
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Arumoy Shome";
        email = "contact@arumoy.me";
      };
      alias = {
        s = "status";
        b = "branch";
        l = "log --oneline --graph";
        bd = "branch -d";
        co = "checkout";
        cof = "checkout --";
        cob = "checkout -b";
        car = "commit --amend --no-edit";
        uncommit = "reset --soft 'HEAD^'";
      };
    };
    ignores = [
      ".DS_Store"
      "._*"
      ".AppleDouble"
      "*.sw[nop]"
      ".bundle"
      ".byebug_history"
      ".env"
      "db/*.sqlite3"
      "rerun.txt"
      "tmp"
      "!tmp/cache/.keep"
      "*.zip"
      "*.tar.bz2"
      "*.pyc"
      "*.pyo"
      "__pycache__"
      ".ipynb_checkpoints"
      ".venv"
      ".pytest_cache"
      ".ruff_cache"
      ".mypy_cache"
      "*.egg-info"
      "dist"
      "build"
      "node_modules"
      ".projections.json"
      "TAGS"
      ".TAGS"
      "tags"
      ".tags"
      ".direnv"
      ".envrc"
      ".claude"
      "result"
      "result-*"
      "*.pem"
      "*.key"
      "*.bcf"
      "*.blg"
      "*.bbl"
      "*.nav"
      "*.xml"
      "*.snm"
      "*.toc"
      "*.xdv"
      "*.aux"
      "*.out"
      "*.fls"
      "*.fdb_latexmk"
      "*.log"
      "*.lot"
      "*.lof"
      ".synctex"
      ".synctex(busy)"
      ".synctex.gz"
      ".synctex.gz(busy)"
    ];
  };
  programs.gitui.enable = false;
  programs.lazygit.enable = true;
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    extraConfig = "
      set-option -a terminal-features 'xterm-256color:RGB'
      bind C-v split-window -h -c '#{pane_current_path}'
      bind C-s split-window -v -c '#{pane_current_path}'
    ";
    aggressiveResize = true;
    baseIndex = 1;
    clock24 = true;
    customPaneNavigationAndResize = true;
    disableConfirmationPrompt = true;
    escapeTime = 0;
    focusEvents = true;
    keyMode = "vi";
    mouse = true;
    shortcut = "Space";
  };

  programs.gh.enable = true;
  programs.tex-fmt.enable = true;
  programs.uv.enable = true;
  programs.ripgrep.enable = true;
  programs.fd.enable = true;
  programs.fzf.enable = true;
  programs.starship.enable = true;

  programs.eza = {
    enable = true;
    colors = "auto";
  };

  programs.alacritty = {
    enable = false;
    settings = {
      font.normal.family = "SauceCodePro Nerd Font";
      font.size = 13.0;
    };
  };

  programs.kitty = {
    enable = true;
    font = {
      name = "SauceCodePro Nerd Font";
      size = 13.0;
    };
    keybindings = {
      "kitty_mod+enter" = "launch --cwd=current";
      "cmd+enter" = "launch --cwd=current";
      "kitty_mod+t" = "launch --type tab --cwd=current";
      "cmd+t" = "launch --type tab --cwd=current";
      "kitty_mod+m" = "toggle_layout stack";

    };
    settings = {
      enabled_layouts = "fat,tall,stack";
      tab_title_template =  "{'Z ' if layout_name == 'stack' else ''}{title}";
      tab_bar_min_tabs = 1;
    };
    themeFile = "Catppuccin-Mocha";
  };

  programs.texlive = {
    enable = false;
    extraPackages = tpkgs: { inherit (tpkgs) scheme-full; };
  };

  programs.pandoc.enable = false; # bundled with quarto
  programs.sioyek.enable = false;
  programs.aichat.enable = false;

  programs.ruff = {
    enable = true;
    settings = {};
  };
  programs.ty.enable = true;
}
