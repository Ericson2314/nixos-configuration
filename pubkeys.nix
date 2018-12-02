{ config, pkgs, ... }:

{
  users.extraUsers.jcericson = {
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDCOU1ZtW8Xs5jXt3wpx8gVRNqfQVLK9bE26Kc1+3DZnm7Jfc4BuiIyAV8oQo+SPBE8g28hq1KA1gw0VMQTpci82zNV13yFVxH9/bqQ7kIXQNC69RsGTzX1FWDKjILyKDEAiwy6N/uYg6MBhabZO3AUwCGMVvR8BoQk/N5xu5rhdEIK7fmz7oTeACWp8D8Q/u33JJiinVKThSpbZRb7isdByAQZcfnTrJmBVg7c/ESDBQiY50Iu57V1Lle+EPkZcF2FC9yfl/UWQVRquJOinBDzDyInnhubjP5WnaEsaEkBS5MYjZ0fohOmcAWbgxc0xZ60Jfrb5yULeC/vI2rcThgB john@John-2016-NixOS"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDNPvn7k33PxgX1pQHpHb31/iAgN+UiekFMGQ+dwFRUW3SxpNqOzM7S1vlMItlwy8kvE7omuMyuzOa3owQ5H3PSMHAe5oIb4UmbONvqE12fcXz+22v/JlJOh0Z1VgBJ5iD9ir6re5JZUEsnCDkX74RemKwpzyf9tbolN4WBQIpRM4QC4TjY7jzKIPfo36vbcKzAzcmsyt8QJotH6fz5u7Maxc3Pf3Jy1BxrUtIuGLfZzYS6Bn5JaHImRMH1U1bNIFL8aFholyZIZ5LsWQfSEn1LMaidSkbrDhChZSvWZaehqj5DaX3r9ZmCYNuKYEDzjzyDk85xGRtn7tfrGcKKOFPV jcericson@jcericson-2016-nixos"
    ];
  };
}
