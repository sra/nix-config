{ pkgs, username, ... }:

{
  imports = [ ./work.nix ];

  home-manager.users.${username} = { pkgs, ... }: {
    home = {
      packages = with pkgs; [
        aws-vault
        awscli2
        eksctl
        aws-iam-authenticator
	jdk17
        maven
      ];
    };
    programs = {
      alacritty = {
        settings = {
          font = {
            size = 16;
          };
        };
      };
    };
  };
}
