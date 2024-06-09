# ts-julia-actions

This is a Neovim plugin written in Lua that uses Tree-sitter to transform Julia function definitions from the single-line format to the multiline format.

https://github.com/kdheepak/ts-julia-actions/assets/1813121/b573438e-4987-40a2-84a9-8491d1cb91c3

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

Either automatically:

```lua
return {
  "kdheepak/ts-julia-actions",
  opts = {},
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = { "julia" },
      }
    end,
  },
}
```

Or manually:

```vim
:TSInstall julia
```

### Usage

Place cursor anywhere inside a function and run `:JuliaShortToLongFunctionAction` or `JuliaLongToShortFunctionAction`.
