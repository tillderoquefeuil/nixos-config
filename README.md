# OneClickOS Nix Project

Temporary password for `oneclickstudio` user is `micode`.

### Setup a new machine

```bash
$ cd ~

$ git clone https://github.com/tillderoquefeuil/nixos-config.git
$ cd nixos-config

$ sudo cp /etc/nixos/hardware-configuration.nix ./hosts/test
$ sudo rm /etc/nixos/*

# copy the lv2 plugin
$ mkdir -p ~/.lv2
$ cp -R ./AutoMixer.lv2 ~/.lv2/

$ sudo nixos-rebuild switch --flake .#test
$ systemctl --user restart wireplumber && systemctl --user restart pipewire
```

in an other terminal, run ```journalctl --user -u wireplumber -f``` to see debug

```bash
# list current inputs/outputs
$ pw-link -io
> my-source:capture_MONO
> my-source:input_MONO
> my-sink:monitor_MONO
> my-sink:playback_MONO
> Firefox:output_FL
> Firefox:output_FR

# useful tips :
# - I/O structure is : <node.name>:<portType>_<audio.position>
# - outputs portType are 'monitor', 'capture' or 'output'
# - inputs portType are 'playback' or 'input'
# - Audio position : FL/FR (front left/right), MONO, etc.

# link an input and an output
$ pw-link <output> <input>
```

linking default input with gate node (should work) :
```bash
pw-link alsa_input.pci-0000_03_00.6.analog-stereo:capture_FL input_gate_test:playback_MONO
```

linking default input with automixer node :
```bash
pw-link alsa_input.pci-0000_03_00.6.analog-stereo:capture_FL input_automixer_test:playback_1
```



### FYI
- nix files must be added to git tree in order to be considered by NixOS (or you'll get a _file not found_)