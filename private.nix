{
  config,
  lib,
  pkgs,
  ...
}: {
  users.users.ryan = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    initialPassword = "TEST12324";
    openssh.authorizedKeys.keys = [
    ];
  };
  users.users.root.openssh.authorizedKeys.keys = [
  ];
}
