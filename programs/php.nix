{ pkgs, username, ... }:
{
  users.users.${username} = {

    packages = with pkgs; [
      (php.buildEnv {
        extensions = ({ enabled, all }: enabled ++ ( with all; [
          xdebug
        ]));
        extraConfig = ''
          zend_extension=xdebug
          xdebug.mode=debug
        '';
      })
      php84Packages.composer
      phpunit
    ];
  };
}
