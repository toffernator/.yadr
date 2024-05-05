# .yadr

## Managing the size of the nix store.

I probably just don't understand how to set-up the garbage collection correctly, but I've found I need to do this manually:

```sh
sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 1d
nix store gc
```

