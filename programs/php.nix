{ pkgs, username, ... }:
{
  users.users.${username} = {

    packages = with pkgs; [
      php
      php84Packages.composer
      php84Extensions.xdebug
      phpunit
    ];

    # services.phpfpm = {
    #   phpPackage = pkgs.php;
    #   phpOptions = ''
    #     zend_extension=xdebug
    #   '';
    # };
  };
}
