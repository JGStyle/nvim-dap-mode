local M = {}

function M.setup()
  local dap = require 'dap'

  dap.listeners.after.event_initialized['dap-mode'] = function()
    vim.g.dap_debugging = true
    M.set_keymaps(true)
    M.update_statusline()
  end

  dap.listeners.before.event_terminated['dap-mode'] = function()
    vim.g.dap_debugging = false
    M.set_keymaps(false)
    M.update_statusline()
  end

  dap.listeners.before.event_exited['dap-mode'] = function()
    vim.g.dap_debugging = false
    M.set_keymaps(false)
    M.update_statusline()
  end

  M.update_statusline()
  M.set_keymaps(vim.g.dap_debugging or false)
end

function M.set_keymaps(debug_mode)
  local map_opts = { noremap = true, silent = true }
  if debug_mode then
    vim.api.nvim_set_keymap('n', 'o', "<cmd>lua require'dap'.step_over()<CR>", map_opts)
    vim.api.nvim_set_keymap('n', 'i', "<cmd>lua require'dap'.step_into()<CR>", map_opts)
    vim.api.nvim_set_keymap('n', 'b', "<cmd>lua require'dap'.toggle_breakpoint()<CR>", map_opts)
    vim.api.nvim_set_keymap('n', 'H', "<cmd>lua require('dap.ui.widgets').hover()<CR>", map_opts)
  else
    vim.api.nvim_set_keymap('n', 'o', 'o', map_opts)
    vim.api.nvim_set_keymap('n', 'i', 'i', map_opts)
    vim.api.nvim_set_keymap('n', 'b', 'b', map_opts)
    vim.api.nvim_set_keymap('n', 'H', 'H', map_opts)
  end
end

function M.update_statusline()
  if vim.g.dap_debugging then
    vim.g.dap_status = 'Debugging'
  else
    vim.g.dap_status = 'Normal'
  end
  vim.api.nvim_command 'redrawstatus'
end

return M
