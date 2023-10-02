{ pkgs, ... }:

{

  imports = [ ../cachix.nix ];

  # Set your time zone.
  time = { timeZone = "America/New_York"; };

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
      extra-platforms = aarch64-darwin
      trusted-users = root sra
    '';
  };

  nixpkgs = {
    config = { allowUnfree = true; };
  };

  environment = {
    systemPackages = with pkgs; [
      neovim
      tailscale
      cachix
      python3
      ripgrep
      fd
      gitui
      
    ];
    pathsToLink = [ "/share/zsh" ];
  };

  fonts.fonts = with pkgs; [
    dejavu_fonts
    iosevka
    fira-code
    hack-font
    font-awesome
  ];

  programs = {
    zsh = { enable = true; };
  };
}
