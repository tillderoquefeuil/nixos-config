{ config, pkgs, ... }:

let
  json = pkgs.formats.json { };
in {
  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    # Use wireplumber as the session manager
    wireplumber.enable = true;
  };
}