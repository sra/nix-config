{ pkgs, ... }:

{

  imports = [ ../modules/emacs ../cachix.nix ];

  # Set your time zone.
  time = { timeZone = "Europe/London"; };

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
      extra-platforms = x86_64-darwin aarch64-darwin
      trusted-users = root mryall
    '';
  };

  nixpkgs = {
    config = { allowUnfree = true; };
  };

  environment = {
    systemPackages = with pkgs; [
      vim
      tailscale
      cachix
      python3
    ];
    pathsToLink = [ "/share/zsh" ];
  };

  fonts.packages = with pkgs; [
    dejavu_fonts
    iosevka
    fira-code
    font-awesome
  ];

  programs = {
    zsh = { enable = true; };
    emacsWithMJRPackages = { enable = true; };
  };
}
