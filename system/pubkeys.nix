{ config, pkgs, ... }:

{
  users.extraUsers.klgfollett = {
    openssh.authorizedKeys.keys = [
    ];
  };
}
