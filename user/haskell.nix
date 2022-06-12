{ pkgs, ... }:

{
  home.packages = [
    (import ../dep/obelisk {}).command
  ] ++ (with pkgs; [
    cabal-install
    haskellPackages.ghcid
    haskellPackages.hasktags
    #haskellPackages.nix-thunk
  ]);

  programs.git.ignores = [
    "cabal.project.local"
    "dist-newstyle"
  ];

  #home.file.".ghci".source = ../../../../dotfiles/ghci;
}
