# OneClickOS Nix Project

Temporary password for `oneclickstudio` user is `micode`.

### Setup a new machine

- install NixOS with official ISO
- clone shared config :
```bash
cd ~
git clone https://USERNAME:TOKEN@github.com/oneclickstudio/nixos-config.git
cd nixos-config
mkdir hosts/my-machine-name
sudo cp /etc/nixos/hardware-configuration.nix ./hosts/my-machine-name
sudo rm /etc/nixos/*
```
- then take inspiration from `msi-laptop` default nix config to create `./hosts/my-machine-name/default.nix`
- add an entry to flake.nix's `nixosConfigurations`
- see the **FYI section** at the end of this file


### Run VSCode

`nix run .#vscode .`

### Build OS and switch to new version

`sudo nixos-rebuild switch --flake .#msi-laptop`

### Update flake.lock

`nix flake update`

### Performance monitoring

```bash
intel_gpu_top #intel iGPU monitoring
zenith # CPU / Nvidia GPU
```

### FYI

- nix files must be added to git tree in order to be considered by NixOS (or you'll get a _file not found_)