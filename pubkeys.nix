{ config, pkgs, ... }:

{
  users.extraUsers.john = {
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDCOU1ZtW8Xs5jXt3wpx8gVRNqfQVLK9bE26Kc1+3DZnm7Jfc4BuiIyAV8oQo+SPBE8g28hq1KA1gw0VMQTpci82zNV13yFVxH9/bqQ7kIXQNC69RsGTzX1FWDKjILyKDEAiwy6N/uYg6MBhabZO3AUwCGMVvR8BoQk/N5xu5rhdEIK7fmz7oTeACWp8D8Q/u33JJiinVKThSpbZRb7isdByAQZcfnTrJmBVg7c/ESDBQiY50Iu57V1Lle+EPkZcF2FC9yfl/UWQVRquJOinBDzDyInnhubjP5WnaEsaEkBS5MYjZ0fohOmcAWbgxc0xZ60Jfrb5yULeC/vI2rcThgB john@John-2016-NixOS"
    ];
  };
}
