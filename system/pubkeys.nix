{ config, pkgs, ... }:

{
  users.users.klgfollett = {
    openssh.authorizedKeys.keys = [
    ];
  };
}
