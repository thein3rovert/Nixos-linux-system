let
  # === SYSTEMS ===

  nixos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEimTrJGM5TmMDM32+F9a7OxKqvlbGOxGey7XveDYv1S";

  # === USERS ===
  introvert = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOHslvxbDHisZaTqmsly3ZfSERVOfoEN4qPcVzIzmvIK";

  systems = [
    nixos
  ];

  users = [
    introvert
  ];
in
{
  "secret2.age".publicKeys = systems ++ users;
  # "linkding-env.age".publicKeys = systems ++ users;
}
