# ts-julia-actions

This is a Neovim plugin written in Lua that uses Tree-sitter to transform Julia function definitions from the single-line format to the multiline format.

![](https://user-images.githubusercontent.com/1813121/255385507-a13466b3-60a1-4098-a343-8b25fa8903b7.gif)

### Prerequisites

- Neovim 0.9.0 or above
- Tree-sitter
- Julia Tree-sitter grammar

### Installation

1. Use your favorite plugin manager:

**lazy.nvim**

```lua
return {
  "kdheepak/ts-julia-actions",
  opts = {},
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
}
```

2. Install Julia Tree-sitter grammar

```vim
:TSInstall julia
```

### Usage

Place cursor on `=` and run `:JuliaShortToLongFunctionAction`.
