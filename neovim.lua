--  /$$$$$$$                                /$$       /$$                    
-- | $$__  $$                              | $$      |__/                    
-- | $$  \ $$  /$$$$$$   /$$$$$$   /$$$$$$ | $$   /$$ /$$ /$$$$$$$   /$$$$$$ 
-- | $$$$$$$  /$$__  $$ /$$__  $$ |____  $$| $$  /$$/| $$| $$__  $$ /$$__  $$
-- | $$__  $$| $$  \__/| $$$$$$$$  /$$$$$$$| $$$$$$/ | $$| $$  \ $$| $$  \ $$
-- | $$  \ $$| $$      | $$_____/ /$$__  $$| $$_  $$ | $$| $$  | $$| $$  | $$
-- | $$$$$$$/| $$      |  $$$$$$$|  $$$$$$$| $$ \  $$| $$| $$  | $$|  $$$$$$$
-- |_______/ |__/       \_______/ \_______/|__/  \__/|__/|__/  |__/ \____  $$
--                                                                  /$$  \ $$
--                                                                 |  $$$$$$/
--                                                                  \______/ 
--  /$$$$$$$                  /$$                                            
-- | $$__  $$                | $$                                            
-- | $$  \ $$  /$$$$$$   /$$$$$$$                                            
-- | $$$$$$$  |____  $$ /$$__  $$                                            
-- | $$__  $$  /$$$$$$$| $$  | $$                                            
-- | $$  \ $$ /$$__  $$| $$  | $$                                            
-- | $$$$$$$/|  $$$$$$$|  $$$$$$$                                            
-- |_______/  \_______/ \_______/                                            
--                                                                           
--                                                                           
--                                                                           

return {
    {
        "bjarneo/aether.nvim",
        branch = "v2",
        name = "aether",
        priority = 1000,
        opts = {
            transparent = false,
            colors = {
                -- Background colors
                bg = "#022f31",
                bg_dark = "#022f31",
                bg_highlight = "#2c5b34",

                -- Foreground colors
                -- fg: Object properties, builtin types, builtin variables, member access, default text
                fg = "#ffe26a",
                -- fg_dark: Inactive elements, statusline, secondary text
                fg_dark = "#ffe26a",
                -- comment: Line highlight, gutter elements, disabled states
                comment = "#2c5b34",

                -- Accent colors
                -- red: Errors, diagnostics, tags, deletions, breakpoints
                red = "#e32535",
                -- orange: Constants, numbers, current line number, git modifications
                orange = "#e8872e",
                -- yellow: Types, classes, constructors, warnings, numbers, booleans
                yellow = "#f8c120",
                -- green: Comments, strings, success states, git additions
                green = "#2f8652",
                -- cyan: Parameters, regex, preprocessor, hints, properties
                cyan = "#329f85",
                -- blue: Functions, keywords, directories, links, info diagnostics
                blue = "#52ada8",
                -- purple: Storage keywords, special keywords, identifiers, namespaces
                purple = "#52ada8",
                -- magenta: Function declarations, exception handling, tags
                magenta = "#329f85",
            },
        },
        config = function(_, opts)
            require("aether").setup(opts)
            vim.cmd.colorscheme("aether")

            vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { fg = "#52ada8", bg = "#022f31" })

            -- Enable hot reload
            require("aether.hotreload").setup()
        end,
    },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "aether",
        },
    },
}

--  ,-----. ,--.   ,--.     ,--.       ,--.          ,--.
-- '  .-.  '|  | ,-|  |     |  | ,---. |  |-.  ,---. |  |-.  ,---.
-- |  | |  ||  |' .-. |,--. |  || .-. || .-. '| .-. || .-. '| .-. |
-- '  '-'  '|  |\ `-' ||  '-'  /' '-' '| `-' |' '-' '| `-' |' '-' '
--  `-----' `--' `---'  `-----'  `---'  `---'  `---'  `---'  `---'