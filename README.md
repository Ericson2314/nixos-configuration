# nixos-configuration

Much better than a .dotfiles repo

## Home manager

```sh
"$(nix-build home-manager-entry.nix --no-out-link)/activate"
```

## NixOS

```sh
sudo nix-env -p /nix/var/nix/profiles/system --set "$(nix-build nixos-entry.nix -A system --no-out-link)"
sudo /nix/var/nix/profiles/system/bin/switch-to-configuration switch
```
