{ config, pkgs, ... }:
{

  services.vsftpd = {
    enable = true;
    writeEnable = true; # Allow write operations
    localUsers = true; # Allow local users to login
    anonymousUser = false; # Disable anonymous login
    #chrootLocal = true; # Restrict users to their home directories
    userlistDeny = false; # Users in userlist are allowed instead of denied
    userlist = [ "introvert ftpuser" ]; # List of allowed use

    extraConfig = ''

      # Enable logging
      xferlog_enable=YES

      listen_address=172.20.10.10

      # Retrict home user directories access
      # chroot_local_user=NO
      pasv_enable=YES
      pasv_min_port=10000
      pasv_max_port=10100
      # pasv_address=your.public.ip
      # User-specific configuration
      user_sub_token=$USER
      local_root=/home/$USER/ftp
    '';
  };

  networking.firewall.allowedTCPPorts = [
    20
    21
  ];
  # For passive FTP, you also need to open a range of ports
  networking.firewall.allowedTCPPortRanges = [
    {
      from = 10000;
      to = 10100;
    }
  ];

  environment.systemPackages = with pkgs; [
    inetutils
  ];

}
