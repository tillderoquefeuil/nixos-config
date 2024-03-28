{ config, pkgs, ... }:
{
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

  environment.etc = {
    "pipewire/pipewire.conf".source = ./pipewire/pipewire.conf;
    "wireplumber/wireplumber.conf".source = ./wireplumber/wireplumber.conf;
    "wireplumber/wireplumber.conf.d/test.conf".source = ./wireplumber/wireplumber.conf.d/test.conf;
  };

}