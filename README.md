# Neovim DAP Configuration
Enhances debugging in NeoVim using the Debug Adapter Protocol (DAP). Provides dynamic keybindings for an improved debugging experience.

## Keybindings
While debugging:

 - o: Step over
 - i: Step into
 - b: Toggle breakpoint
 - H: Hover to view current value

Keybindings revert to their default actions when not debugging.

## Installation
Include the setup function in your Neovim configuration:

```lua
require('nvim-dap-mode').setup()
```

