# ts-julia-actions

This is a Neovim plugin written in Lua that uses Tree-sitter to transform Julia function definitions from the single-line format to the multiline format.


https://github.com/kdheepak/ts-julia-actions/assets/1813121/a747470d-5a07-4de2-a4cc-050b7446ee29


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
