# gitmoji.nvim

[Gitmojis](https://gitmoji.dev/) for Neovim

<img src="./gitcommit.gif" align="left"/>

## Installation

You can install the plugin via [Lazy](https://github.com/folke/lazy.nvim) like this:
```lua
{
    "Dynge/gitmoji.nvim",
    dependencies = {
        "hrsh7th/nvim-cmp",
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
```

| Key    | Type    | Defaults | Description    |
|---------------- | -------- | ------- | --------------- |
| `filetypes`    | `table`    | `{"gitcommit"}`| Filetypes to add gitmoji completion to.  |

## Usage

Gitmoji completion simply adds a `gitmoji` source to nvim-cmp setup.

The completion is triggered on the `:` character.

