{ config, pkgs, ... }:

{
  users.extraUsers.jcericson = {
    openssh.authorizedKeys.keys = [
    ];
  };
}
