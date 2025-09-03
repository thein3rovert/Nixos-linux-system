{ config, ... }:
let

in
{
  # Create option for vvirtualisation service names
  # TODO: Kill process 9090 (docker version)
  virtualisation.oci-containers.containers."linkding" = {
    image = "sissbruecker/linkding:latest";
    ports = [ "127.0.0.1:9091:9090" ];
    volumes = [ "linkding_data:/etc/linkding/data" ];
    environment = {
      LD_DISABLE_BACKGROUND_TASKS = "true";
      LD_SUPERUSER_NAME = "thein3rovert";
      LD_SUPERUSER_PASSWORD = "linkdinsam4496";
    };
  };
}
