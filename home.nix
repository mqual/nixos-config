{
  config,
  pkgs,
  inputs,
  ...
}:

{
  home.username = "haxfn";
  home.homeDirectory = "/home/haxfn";
  home.stateVersion = "25.11";

  home.packages = [
    #inputs.ki-editor.packages.${pkgs.system}.default
    pkgs.nixfmt
    pkgs.just
    pkgs.direnv
    pkgs.gcc
  ];

  home.sessionVariables = {
    EDITOR = "ki";
    VISUAL = "ki";
  };

  programs.home-manager.enable = true;
  programs.kitty.enable = true;
  programs.gh.enable = true;
  programs.nushell = {
    enable = true;
    configFile.source = ./nushell/config.nu;
  };
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };
}
