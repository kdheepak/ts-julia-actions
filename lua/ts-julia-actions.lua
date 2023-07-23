local M = {}

local ts_utils = require("nvim-treesitter.ts_utils")

function M.set_repeat(fn)
  return function(...)
    local args = { ... }
    local nargs = select("#", ...)
    vim.go.operatorfunc = "v:lua.require'ts-julia-actions'.repeat_action"

    M.repeat_action = function()
      fn(unpack(args, 1, nargs))

      local action =
        vim.api.nvim_replace_termcodes(string.format("<cmd>call %s()<cr>", vim.go.operatorfunc), true, true, true)

      pcall(vim.fn["repeat#set"], action, -1)
    end

    vim.cmd("normal! g@l")
  end
end

M.julia_actions = {}

function M.setup(opts)
  M.julia_actions = vim.tbl_deep_extend("force", M.julia_actions, opts or {})

  vim.api.nvim_create_user_command(
    "JuliaShortToLongFunctionAction",
    M.short_to_long_function,
    { desc = "Performs short to long function action on the node under the cursor." }
  )
end

local function get_node_text(bufnr, node)
  local start_row, start_col, end_row, end_col = node:range()
  if start_row ~= end_row then
    return nil
  end
  local line = vim.api.nvim_buf_get_lines(bufnr, start_row, start_row + 1, false)[1]
  return line:sub(start_col + 1, end_col)
end

local function split_into_lines(str)
  local lines = {}
  for line in str:gmatch("[^\r\n]+") do
    table.insert(lines, line)
  end
  return lines
end

M.short_to_long_function = M.set_repeat(function()
  local bufnr = vim.api.nvim_get_current_buf()
  local node = ts_utils.get_node_at_cursor()
  -- TODO: currently only works when cursor is on `=` in short_function_definition
  if node:type() == "short_function_definition" then
    local function_name_node = node:named_child(0) -- Replace with correct child index
    local parameters_node = node:named_child(1) -- Replace with correct child index
    local body_node = node:named_child(2) -- Replace with correct child index

    local function_name = get_node_text(bufnr, function_name_node)
    local parameters = get_node_text(bufnr, parameters_node)
    local body = get_node_text(bufnr, body_node)

    -- Prepare the transformed function
    -- TODO: preserve indentation of original function
    local transformed = string.format("function %s%s\n  %s\nend", function_name, parameters, body)
    local transformed_lines = split_into_lines(transformed)

    -- Replace the function definition in the buffer with the transformed version
    local start_row, start_col, end_row, end_col = node:range()
    vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, transformed_lines)
  else
    print("The current node is not a short function definition.")
  end
end)

return M
