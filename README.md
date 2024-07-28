# .yadr

## File layout

```
home/
    \_ [username]/
        \_ common/: Home configuration for the user across all OS options
        \_ darwin/: Home configuration for the user specific to darwin systems
        \_ nixos/: Home configuration for the user specific to nixos systems
        \_ part/: Splits the users home configuration into more manageable parts
os
    \_ common/: System configuration to be applied unilaterally across all systems
    \_ darwin/: System configuration to be applied unilaterally across all darwin systems
    \_ nixos/: System configuration to be applied unilaterally across all nixos systems
host
    \_ [hostname]: System configuration specific to the host
```

## Managing the size of the nix store

I probably just don't understand how to set-up the garbage collection correctly, but I've found I need to do this manually:

```sh
nh clean all
```

