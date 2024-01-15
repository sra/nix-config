{ pkgs, nur, username, ... }:
let
  foo = "bar";
in
{
  home-manager.users.${username} = { pkgs, ... }: {

    nixpkgs = {
      config = { allowUnfree = true; };
    };

    home = {
      stateVersion = "22.05";

      packages = with pkgs; [
        difftastic
        eza
        fd
        just
        ncdu
        nixpkgs-fmt
        rnix-lsp
        yq
      ];
      sessionVariables = { 
        EDITOR = "nvim";
      };

    };

    programs = {
      home-manager = { enable = true; };
      neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
	plugins = with pkgs.vimPlugins; [
	  ale
	  fzf-vim
	  lightline-vim
	  neoformat
	  splitjoin-vim
	  supertab
	  tabular
	  ultisnips
	  vim-abolish
	  vim-commentary
	  vim-endwise
	  vim-eunuch
	  vim-fugitive
	  vim-gruvbox8
	  vim-mundo
	  vim-polyglot
	  vim-repeat
	  vim-surround
	  vim-test
	  vim-unimpaired
	  vim-visualstar
	];
      };

      ssh = {
        enable = true;
        compression = true;
        forwardAgent = true;
      };

      git = {
        enable = true;
        delta.enable = true;
        delta.options = {
          features = "side-by-side";
          syntax-theme = "Solarized (dark)";
        };
        aliases = {
          st = "status";
          ci = "commit";
          co = "checkout";
          br = "branch";
          ix = "diff --cached";
          lg =
            "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
        };
        extraConfig = {
          core = {
            whitespace = "nowarn";
            editor = "nvim";
          };
          color = {
            branch = "auto";
            diff = "auto";
            status = "auto";
          };

          push = { default = "simple"; };
          pull = { ff = "only"; };
          github = { user = "sra"; };
          diff = { tool = "difftastic"; };
          difftool = { prompt = false; };
          difftool = {
            difftastic = {
              cmd = ''difft "$LOCAL" "$REMOTE"'';
            };
          };
          pager = { difftool = true; };
          branch = { autoSetupMerge = true; };
        };
      };

      gpg = { enable = true; };
      bat = { enable = true; };
      broot = {
        enable = true;
        enableZshIntegration = true;
      };
      zoxide = {
        enable = true;
        enableZshIntegration = true;
      };
      htop = { enable = true; };
      jq = { enable = true; };
      password-store = {
        enable = true;
        package = pkgs.pass.withExtensions (exts: [
          # exts.pass-import
          # exts.pass-audit
          # exts.pass-otp
        ]);
      };
      firefox = {
        enable = true;
        profiles = {
          sra = {
            id = 0;
            settings = {
              "browser.urlbar.placeholderName" = "DuckDuckGo";
              "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
              "ui.key.accelKey" = "91";
            };
            extensions = with nur.repos.rycee.firefox-addons; [
              ghosttext
              org-capture
              privacy-badger
              sidebery
              tridactyl
            ];
          };
        };

      };

      zsh = {
        enable = true;
        enableCompletion = true;
        enableAutosuggestions = true;
        #defaultKeymap = "vicmd";
        history = { ignoreDups = true; };
        plugins = [{
          name = "fast-syntax-highlighting";
          src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
        }];
        shellAliases = {
          k = "kubectl";
          ls = "eza --icons --git";
          ns = "nix-shell";
          t = "/Applications/Tailscale.app/Contents/MacOS/Tailscale";
        };
        prezto = {
          enable = true;
          color = true;
          editor = {
            promptContext = true;
            dotExpansion = true;
          };
          prompt = { theme = "pure"; };
        };
        localVariables = { ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=10"; };
        initExtraFirst = ''
          [[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' && return
        '';
        initExtra = ''
          bindkey "\e[1;3D" backward-word
          bindkey "\e[1;3C" forward-word
          function nx() { nix-shell -p "$1" --run "$1" }
        '';
      };

      direnv = {
        enable = true;
        nix-direnv = {
          enable = true;
        };
        enableZshIntegration = true;
      };

      fzf = {
        enable = true;
        enableZshIntegration = true;
        defaultOptions = [
          "--color dark,hl:33,hl+:37,fg+:235,bg+:136,fg+:254"
          "--color info:254,prompt:37,spinner:108,pointer:235,marker:235"
        ];
      };

      zellij = {
        enable = false;
        enableZshIntegration = true;
        settings = {
          #theme = "solarized-dark";
          theme = "gruvbox-dark";
          ui = {
            pane_frames = { rounded_corners = true; };
          };
          keybinds = {
            #unbind = [ "Ctrl g" "Ctrl p" "Ctrl n" "Ctrl b" ];
          };
        };
      };

      alacritty = {
        enable = false;
        settings = {
          env = { TERM = "xterm-256color"; };
          font = {
            normal = {
              family = "Iosevka Nerd Font";
            };
          };
          window = {
            #decorations = "none";
            option_as_alt = "OnlyLeft";
          };
          mouse_bindings = [
            { mouse = "Middle"; action = "PasteSelection"; }
          ];
          colors = {
            primary = {
              background = "#002b36";
              foreground = "#ffffff";
              dim_foreground = "#1e1e1e";
              bright_foreground = "#ffffff";
              normal = {
                black = "#002b36";
                red = "#ff5f59";
                green = "#44bc44";
                yellow = "#d0bc00";
                blue = "#2fafff";
                magenta = "#feacd0";
                cyan = "#00d3d0";
                white = "#ffffff";
              };
              bright = {
                black = "#002b36";
                red = "#ff5f5f";
                green = "#44df44";
                yellow = "#efef00";
                blue = "#338fff";
                magenta = "#ff66ff";
                cyan = "#9ac8e0";
                white = "#ffffff";
              };
              dim = {
                black = "#002b36";
                red = "#ff9580";
                green = "#88ca9f";
                yellow = "#d2b580";
                blue = "#82b0ec";
                magenta = "#caa6df";
                cyan = "#9ac8e0";
                white = "#989898";
              };
            };
          };
        };
      };

      #dircolors = {
        #enable = true;
        #enableZshIntegration = true;
      #};
    };
  };
}
