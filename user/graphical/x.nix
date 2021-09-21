{ pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  xsession = {
    enable = true;

    windowManager.xmonad = {
      enable = true;
      # TODO: Patch xmonad-contrib to fix
      # https://github.com/xmonad/xmonad-contrib/issues/280
      enableContribAndExtras = true;
      config = ./xmonad.hs;
      #extraPackages = p: with p; [ taffybar ];
    };
    pointerCursor = {
      name = "Vanilla-DMZ";
      package = pkgs.vanilla-dmz;
    };
  };

  #services.taffybar.enable = true;
  xdg.configFile."taffybar/taffybar.hs".source = ./taffybar.hs;

  xresources.properties = {
    # A nice desktop size
    #"*.dpi" = 120;
    # A nice laptop size:
    #"*.dpi" = 150;
    # Double pixels:
    #"*.dpi" = 192;
  };

  home.packages = with pkgs; [
    dmenu
    thunderbird
    chromium
    element-desktop
    signal-desktop
  ];

  services.redshift = import ./redshift.nix;
}
