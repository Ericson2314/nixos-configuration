{ config, pkgs, ... }:

{
  users.extraUsers.john = {
    openssh.authorizedKeys.keys = [
      "ssh-rsa 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 jcericso@cslab7a"

      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDMpWQHoWkBMSVr+jsfq42YjoZdv0svatCqFD9KYLmxTnbe1TH2EmcEOsygbrgqrcMwughRIkxY1iwbSnA3Jbr7xg/XhLvFV9BeAeIKAAhfmC/6VM8WgTgjs4g+JOg/kPu+vzEpUeNsBAU9bAPsMXt1oZI3gIW0rdhlSYIUbcp1yvnZaMvX9s94s1AJa/4HxOtKviewls8NJ+cfCWtWZDfFUCe3eGBqyKzPtkwDCqMsKZ1qfL+VPE6f8vu/Lf5ySoE08k2fWmQwN8qrIpeLYLD0HuWn6VbgS2RDIDRLWjd4FDli6pVwBPDklQOMnDO22pHcZSYOd9ya83Dt7fRlJjWh jcericso@ENG-EL11"

      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDvNSfyX0ojITNczIcsI658sG8oOm/Fvf5b3zWAWf1mpHa5ZKcO5Mp+IPPr9CzsWDPn5Nw4XOp3QQefIF6JZECAaBDDQqv84X8A9k6U5bhmZDhr1rUqmE6gmhqWvdYBgFmhjzwXHYPHYfp6urrgxrPEa2vtpUQjgAbDf7/lizDgf0EhsF6jJbiiMZCStMXvYjmNDirNvA9jlOwIObXsF80vuqPjH6tXCkEU1k21gnTivRc+JpUDUe74DhIOZhiIdjI/JRRrm5r8JeWsV62rMSaVApo6LY16Cu/i2kWHCHshOkh4hFz27goDI2zPqhvMXUVpgHtjYZh0RR96M8QmCM75 john@John-Delphix-Nix"
    ];
  };
}