{ pkgs, username, ... }:
{
  users.users.${username} = {

    packages = with pkgs; [
      (php.buildEnv {
        extensions = ({ enabled, all }: enabled ++ ( with all; [
          xdebug
          composer
        ]));
        extraConfig = ''
          xdebug.mode=debug
        '';
      })
      phpunit
    ];
  };
}
