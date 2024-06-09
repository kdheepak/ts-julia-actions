# This is a vhs script. See https://github.com/charmbracelet/vhs for more info.
Output "vhs/showcase.mp4"
Set Theme "Catppuccin Frappe"
Set WindowBar Colorful
Set Width 1200
Set Height 800
Hide
Sleep 2.5s
Type "~/.local/share/mise/installs/neovim/nightly/bin/nvim test/runtests.jl"
Enter
Sleep 5s
Show
Sleep 2.5s
Type "gg0"
Type ":JuliaShortToLongFunctionAction"
Sleep 500ms
Enter
Sleep 1.5s
Type "jjjj"
Sleep 1.5s
Type ":JuliaShortToLongFunctionAction"
Sleep 500ms
Enter
Sleep 1.5s
Type "jjjjjjjj"
Sleep 1.5s
Type ":JuliaShortToLongFunctionAction"
Sleep 500ms
Enter
Sleep 1.5s
Type "jjjj"
Sleep 1.5s
Type ":JuliaShortToLongFunctionAction"
Sleep 500ms
Enter
Sleep 1.5s
Type ":JuliaLongToShortFunctionAction"
Sleep 500ms
Enter
Sleep 1.5s
Type "kkkk"
Sleep 1.5s
Type ":JuliaLongToShortFunctionAction"
Sleep 500ms
Enter
Sleep 1.5s
Type "kkkkkkkk"
Sleep 1.5s
Type ":JuliaLongToShortFunctionAction"
Sleep 500ms
Enter
Sleep 1.5s
Type "kkkk"
Sleep 1.5s
Type ":JuliaLongToShortFunctionAction"
Sleep 500ms
Enter
Sleep 1.5s
Hide
Type ":wqa"
Sleep 500ms
Enter
Sleep 1.5s
