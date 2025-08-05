# Configuration module for global user parameters

{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.parameters.user;
in {
  options.parameters.user = {

    # Common user configuration duplicated all over the place
    
    username = mkOption {
      type = types.str;
      default = "mguillen"; 
      description = ''
        The technical username of the user.
      '';
    };

    email = mkOption {
      type = types.str;
      default = "mguillen@domain.com"; 
      description = ''
        The user email adresss.
      '';
    };

    secondary-email = mkOption {
      type = types.str;
      default = cfg.email; 
      description = ''
        The user alternative email adresss.
      '';
    };

    description = mkOption {
      type = types.str;
      default = "Marc Guillen"; 
      description = ''
        The user description, usually the full name.
      '';
    };

    context = mkOption {
      type = types.str;
      default = "work"; 
      description = ''
        The context of the user e.g. work, home use switch some settings.
      '';
    };

    # Configuration flags
    
    enableLightsaber = mkOption { 
      type = types.bool;
      default = true;
      description = ''
        Enable the full lightsaber configuration. 
      '';
    };

    enableExtra = mkOption { 
      type = types.bool;
      default = false;
      description = ''
        Enable extra applications in the configuration.
        Extra application are usually not yet managed by home-manager. 
      '';
    };

    enableTest = mkOption { 
      type = types.bool;
      default = false;
      description = ''
        Enable applications currently in test in the configuration. 
      '';
    };
    
  };

  config = {
    # This module just holds option values, that other cann refere to.
    # It is not meant to set directly value in other module, I prefer a loww profile.s
  };

}
