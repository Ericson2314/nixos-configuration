{ pkgs, ... }:

{
  programs.fish.enable = true;
  programs.fish.package = pkgs.fish.overrideAttrs (old: {
    patches = old.patches ++ [
      # https://github.com/fish-shell/fish-shell/pull/5637 is merged but not
      # yet released. Need this for sane behavior on macOS.
      (pkgs.fetchpatch {
        url = "https://patch-diff.githubusercontent.com/raw/fish-shell/fish-shell/pull/5637.diff";
        sha256 = "020f18pglsdh3ah28qyvni0986spv2gbha67gbcirzr2xspsfc45";
        excludes = [ "CHANGELOG.md" ];
      })
    ];
  });
  programs.fish.promptInit = builtins.readFile ./fish_prompt.fish;
  xdg.configFile."fish/functions".source = ./functions;
}
