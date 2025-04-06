# gitmoji.nvim

[Gitmojis](https://gitmoji.dev/) for Neovim using [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) or [blink.nvim](https://github.com/saghen/blink.cmp)

<img src="./gitcommit.gif" align="left"/>

## Installation

You can install the plugin via [Lazy](https://github.com/folke/lazy.nvim) like this:

```lua
{
    "Dynge/gitmoji.nvim",
    dependencies = {
        "hrsh7th/nvim-cmp", -- for nvim-cmp completion
        "Saghen/blink.cmp", -- for blink completion
    },
    opts = {},
    ft = "gitcommit",
},
```

## Configuration

Configuration and setup is done by calling the `.setup()` method like so:

```lua
-- directly calling setup
require("gitmoji").setup({})

-- or using ´opts´ table in lazy table
{
    "Dynge/gitmoji.nvim",
    dependencies = {
        "hrsh7th/nvim-cmp", -- for nvim-cmp completion
        "Saghen/blink.cmp", -- for blink completion
    },
    opts = { -- the values below are the defaults
        filetypes = { "gitcommit" },
        completion = {
            append_space = false,
            complete_as = "emoji",
        },
    },
    ft = "gitcommit",
}
```

> **_Note:_**
> For more details on the config options read the [help](./doc/gitmoji.txt) file.

### Setup with nvim-cmp

Gitmoji completion simply adds a `gitmoji` source to nvim-cmp setup.

Be sure to set the source into your nvim-cmp opts:

```lua
require("cmp").setup({
  sources = {
    { name = 'gitmoji' }
  })
})
```

### Setup with blink

When using blink the setup via `require("gitmoji").setup(opts)` will be ignored, instead the options are set in the setup of `blink` under `providers`:

```lua
require("blink").setup({
    sources = {
        default = {
            -- your sources
            -- ...
            "gitmoji"
        },
        providers = {
            gitmoji = {
                name = "gitmoji",
                module = "gitmoji.blink",
                opts = { -- gitmoji config values goes here
                    filetypes = { "gitcommit", "jj" },
                },
            },
        },
    },
})


## Usage

The completion is triggered on the `:` character.

```
