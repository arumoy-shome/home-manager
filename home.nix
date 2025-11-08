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
    pkgs.nerd-fonts.sauce-code-pro
    pkgs.lilex
    pkgs.ltex-ls-plus
    pkgs.typst
  ];

  home.file = {
    ".editorconfig".source = files/editorconfig;
    ".hammerspoon" = {
      source = files/hammerspoon;
      recursive = true;
    };
  };

  home.sessionVariables = {
  };

  editorconfig.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.emacs = {
    enable = false;
    extraPackages = epkgs: [
      epkgs.nix-mode
      epkgs.markdown-mode
      epkgs.olivetti
      epkgs.diminish
      epkgs.auctex
      epkgs.exec-path-from-shell
      epkgs.evil
      epkgs.evil-org
      epkgs.evil-surround
      epkgs.evil-commentary
      epkgs.evil-collection
      epkgs.orderless
      epkgs.consult
      epkgs.corfu
      epkgs.magit
      epkgs.org-modern
      epkgs.denote
    ];
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
    enable = false;
    defaultEditor = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      mini-nvim
      vimtex
      conform-nvim
      nvim-lspconfig
      nvim-treesitter
      nvim-treesitter-parsers.latex
      nvim-treesitter-parsers.bibtex
      nvim-treesitter-parsers.nix
      nvim-treesitter-parsers.python
      nvim-treesitter-parsers.typst
    ];
  };

  programs.vim = {
    enable = true;
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

    initContent = ''
      if [[ $(uname -m) == 'arm64' ]]
      then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      fi
    '';

    history = {
      append = true;
      expireDuplicatesFirst = true;
      ignoreAllDups = true;
      saveNoDups = true;
    };

    oh-my-zsh = {
      enable = true;
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
      ".ipynb_checkpoints"
      ".venv"
      "node_modules"
      ".projections.json"
      "TAGS"
      ".TAGS"
      "tags"
      ".tags"
      ".direnv"
      ".envrc"
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
      ".synctex"
      ".synctex(busy)"
      ".synctex.gz"
      ".synctex.gz(busy)"
      "*.fdb_latexmk"
      "*.fdb_latexmk"
    ];
  };
  programs.gitui.enable = false;
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    extraConfig = "
      set-option -a terminal-features 'xterm-256color:RGB'
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
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
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
      name = "Lilex";
      size = 20.0;
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
    shellIntegration.enableZshIntegration = true;
    themeFile = "Modus_Vivendi";
  };

  programs.texlive = {
    enable = true;
    extraPackages = tpkgs: { inherit (tpkgs) scheme-full; };
  };

  programs.pandoc.enable = true;
  programs.sioyek.enable = false;
  programs.aichat.enable = false;

  programs.ruff = {
    enable = true;
    settings = {};
  };
}
