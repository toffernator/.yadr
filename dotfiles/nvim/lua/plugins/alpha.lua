return {
    'goolord/alpha-nvim',
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        local logo = {
            "        .--'''''''''--.",
            "     .'      .---.      '.",
            "    /    .-----------.    \\",
            "   /        .-----.        \\",
            "   |       .-.   .-.       |",
            "   |      /   \\ /   \\      |",
            "    \\    | .-. | .-. |    /",
            "     '-._| | | | | | |_.-'",
            "         | '-' | '-' |",
            "          \\___/ \\___/",
            "       _.-'  /   \\  `-._",
            "     .' _.--|     |--._ '.",
            "     ' _...-|     |-..._ '",
            "            |     |",
            "LGB         '.___.'",
        }
        dashboard.section.header.val = logo;
        alpha.setup(dashboard.opts)
    end
};
