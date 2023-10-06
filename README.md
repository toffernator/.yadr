# yadr

This repository contains my full system configurations as well as dotfiles for configuring specific programs.
It is still very much WIP, in the future I aim to use home-manager and nix to handle everything (so few bash scripts / relying on embedded bash in nix).
However, I am still learning these tools and I also want a usable system now, so until then it will be a good mix.

## Install

```sh
./install.sh
```

## Thoughts

I recommend reading the files in execution order.
First `flake.nix` is executed, which imports (calls on) `hosts/default.nix`, and so on.
An import means that execution jumps there to evaluate that .nix file (uses default.nix if directory specified)

If you want to know more about the options being configured use the nixos-option tool, e.g.:
```sh
nixos-option security.rtkit.enabled
```

