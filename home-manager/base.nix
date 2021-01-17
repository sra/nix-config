# 1. Install NixOs config
# 2. Git clone nix-home
# 3. ln -s nix-home ~/.config/nixpkgs
# ?? 4. nix-env -f '<nixpkgs>' -iA home-manager

# 5. nix-channel --add https://github.com/rycee/home-manager/archive/release-20.09.tar.gz home-manager
# 6. nix-channel --update
# 7. nix-shell '<home-manager>' -A install

{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    awscli
    graphviz
    htop
    isync
    jq
    multimarkdown
    # nix-linter
    proselint
    python37Packages.yamllint
    rnix-lsp
    shellcheck
    sqlite
    tree
    weechat
    wrk
  ];

  programs.git = {
    enable = true;
    delta.enable = true;
    delta.options =  {
      features = "side-by-side";
      syntax-theme = "Solarized (dark)";
    };
    userName = "Matthew Ryall";
    userEmail = "matthew@mexico86.co.uk";
    aliases = {
      st = "status";
      ci = "commit";
      co = "checkout";
      br = "branch";
      ix = "diff --cached";
      lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
    };
    extraConfig = builtins.readFile ~/Config/system-config/git/.gitconfig;
  };

  programs.zsh = {
    enable = true;
    initExtra = builtins.readFile ~/Config/system-config/zsh/.zshrc-antigen;
  };

  programs.direnv = {
    enable = true;
    enableNixDirenvIntegration = true;
  };

}
