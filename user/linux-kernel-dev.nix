{ ... }:

let
  # `programs.b4` isn't in home manager 26.05 yet, so fetch just that one
  # module from master for now. The packages it defaults to (`b4` with
  # `passthru.src-misc`, `vimPlugins.b4-review-vim`,
  # `emacsPackages.b4-review-mode`) are all in our nixpkgs 26.05 already.
  #
  # Delete this once we're on a home manager release that ships the module.
  b4-module = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/nix-community/home-manager/2ba72d023755993fda4c49a46db51682ffc02ac4/modules/programs/b4.nix";
    sha256 = "1g854gn9ylrh41lmcya2kyy2gdxcchb008sd7w9nbidpgkjkbsbr";
  };
in
{
  imports = [ b4-module ];

  programs.b4.enable = true;

  # TODO add Sashiko (https://sashiko.dev, agentic kernel patch review) to
  # `home.packages` once it is in nixpkgs.
}
