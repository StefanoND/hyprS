{ config, pkgs, lib, specialArgs, ... }:
let
  helpers = import ./helpers.nix {
    inherit pkgs;
    inherit lib;
    inherit config;
    inherit specialArgs;
  };

in {
  nixpkgs = {
    config = {
      allowUnfree = config.allowUnfree or false;
      allowUnfreePredicate = config.allowUnfreePredicate or (x: false);
    };
  };

  home.stateVersion = specialArgs.version;
  home.username = pkgs.config.username;
  home.homeDirectory = pkgs.config.home;

  home.packages = [
    (helpers.nixGLVulkanNvidiaWrap pkgs.steam)
    (helpers.nixGLVulkanNvidiaWrap pkgs.lutris)
    (helpers.nixGLVulkanNvidiaWrap pkgs.retroarchFull)
    (helpers.nixGLVulkanNvidiaWrap pkgs.gamescope)
    (pkgs.mangohud)
  ];

  programs.home-manager.enable = true;
}
