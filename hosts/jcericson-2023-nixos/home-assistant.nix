{ config, ... }:

let
  server_port = config.services.home-assistant.config.http.server_port;
  host = "home.johnericson.me";
in

{
  services.home-assistant = {
    enable = true;
    extraComponents = [
      # Components required to complete the onboarding
      "esphome"
      "met"
      "radio_browser"

      # For My Window AC
      "matter"
    ];
    config = {
      # Includes dependencies for a basic setup
      # https://www.home-assistant.io/integrations/default_config/
      default_config = {};
      http = {
        server_host = "::1";
        trusted_proxies = [ "::1" ];
        use_x_forwarded_for = true;
      };
    };
  };

  services.avahi = {
    nssmdns4 = true;
    enable = true;
    ipv4 = true;
    ipv6 = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };

  services.matter-server.enable = true;

  security.acme = {
    acceptTerms = true;
    defaults.email = "webmaster@JohnEricson.me";
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts.${host} = {
      forceSSL = true;
      enableACME = true;
      extraConfig = ''
        proxy_buffering off;
      '';
      locations."/" = {
        proxyPass = "http://[::1]:${toString server_port}";
        proxyWebsockets = true;
      };
    };
  };

  networking.firewall.allowedTCPPorts = [
    # Only needs to be open when initialzing with Let's Encrypt
    # config.services.nginx.defaultHTTPListenPort
    config.services.nginx.defaultSSLListenPort
  ];
}
