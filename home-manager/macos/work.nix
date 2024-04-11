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
          "ftpmotion" = {
            hostname = "3.228.82.208";
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
            hostname = "184.72.241.143";
            user = "centos";
          };
          "stream01-e1" = {
            hostname = "52.203.82.192";
            user = "root";
          };
          "stream02-e1" = {
            hostname = "34.198.168.154";
            user = "root";
          };
          "stream03-e1" = {
            hostname = "35.170.111.35";
            user = "root";
          };
          "stream04-e1" = {
            hostname = "34.204.121.19";
            user = "root";
          };
          "stream05-e1" = {
            hostname = "3.220.227.249";
            user = "root";
          };
          "stream06-e1" = {
            hostname = "3.218.42.217";
            user = "root";
          };
          "stream07-e1" = {
            hostname = "54.156.7.208";
            user = "root";
          };
          "stream08-e1" = {
            hostname = "18.211.43.147";
            user = "root";
          };
          "stream10-e1" = {
            hostname = "54.86.151.173";
            user = "root";
          };
          "stream99-e1" = {
            hostname = "54.226.104.69";
            user = "root";
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
