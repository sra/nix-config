{ pkgs, username, ... }:

let
  adr-tools = import ../../pkgs/adr-tools { inherit pkgs; };
in
{
  imports = [ ./base.nix ];

  home-manager.users.${username} = { pkgs, ... }: {
    home = {
      username = "scottanderson";
      homeDirectory = "/Users/scottanderson";

      packages = with pkgs; [
        # adr-tools
        #dbeaver
        # jetbrains.idea-community
        #jwt-cli
        #jira-cli-go
        pgformatter
        kubectl
        kubernetes-helm
        kubelogin
        k9s
        ssm-session-manager-plugin
        tidyp
        xh
        aws-vault
        awscli2
        devbox
        aws-iam-authenticator
        pv
      ];

      sessionVariables = {
        JIRA_EDITOR = "nvim";
        JIRA_API_TOKEN = "";
      };
    };

    programs = {
      ssh = {
        controlPersist = "yes";
        controlMaster = "auto";
        controlPath = "/tmp/%r@%h:%p";
        serverAliveInterval = 20;
        serverAliveCountMax = 2;
        extraConfig = ''
          IdentityAgent ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
        '';

        matchBlocks = {
          "xgithub.com" = {
            hostname = "github.com";
            user = "git";
          };
          "ts-gw1" = { 
            user = "ec2-user";
          };
          "ts-gw-tl1" = { 
            user = "ec2-user";
          };
          "win01-e1" = { # meh
            hostname = "34.198.105.85";
            user = "root";
          };
          "quickbooks" = { # meh
            hostname = "34.198.249.102";
            user = "root";
          };
          "motion" = {
            hostname = "3.210.212.36";
            user = "centos";
          };
          "ftp-motion-proxy" = {
            user = "ec2-user";
          };
          "axis01-e1" = {
            hostname = "34.200.22.53";
            user = "root";
          };
          "dev01-e1-ntp" = {
            hostname = "52.206.232.112";
            user = "root";
          };
          "app01-e1-ntp" = {
            hostname = "34.194.104.115";
            user = "root";
          };
          "edge01-e1" = {
            hostname = "54.85.226.172";
            user = "root";
          };
          "sdc01-e1" = {
            hostname = "3.235.58.140";
            user = "centos";
          };
          "stream*-e1" = {
            user = "ec2-user";
          };
          "stream01-e1-old" = {
            user = "centos";
          };
          "stream02-e1-old" = {
            user = "centos";
          };
          "stream03-e1-old" = {
            user = "centos";
          };
        };
      };
      git = {
        userName = "Scott Anderson";
        userEmail = "scott.anderson@truelook.com";
        #signing = {
          #key = "0902EF0CB4879CEB";
          #signByDefault = true;
        #};
      };
    };
  };
}
