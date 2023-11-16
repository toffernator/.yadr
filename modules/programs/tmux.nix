{ pkgs, vars, ... }:

{
    home-manager.users.${vars.user} = {
        programs = {
            tmux = {
                enable = true;
            };
        };
    };
}
