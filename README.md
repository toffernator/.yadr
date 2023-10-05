# yadr

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

