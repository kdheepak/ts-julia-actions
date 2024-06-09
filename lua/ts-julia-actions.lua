local M = {}

local ts_utils = require("nvim-treesitter.ts_utils")

M.julia_actions = {}

function M.setup(opts)
  M.julia_actions = vim.tbl_deep_extend("force", M.julia_actions, opts or {})

  vim.api.nvim_create_user_command(
    "JuliaShortToLongFunctionAction",
    M.short_to_long_function,
    { desc = "Performs short to long function action on the TS node under the cursor." }
  )

  vim.api.nvim_create_user_command(
    "JuliaLongToShortFunctionAction",
    M.long_to_short_function,
    { desc = "Performs long to short function action on the TS node under the cursor." }
  )
end

function M.config(opts)
  M.setup(opts)
end

local function split_into_lines(str)
  local lines = {}
  for line in str:gmatch("[^\r\n]+") do
    table.insert(lines, line)
  end
  return lines
end

local function _get_parent_function_node()
  local node = ts_utils.get_node_at_cursor()
  while node do
    if node:type() == "function_definition" then
      break
    else
      node = node:parent()
    end
  end
  if node == nil then
    return nil
  end

  return node
end

M.long_to_short_function = function()
  local bufnr = vim.api.nvim_get_current_buf()

  local function_node = _get_parent_function_node()

  if function_node then
    local call_expr = vim.treesitter.get_node_text(function_node:named_child(0), bufnr)
    if function_node:named_child_count() > 2 then
      local children = ts_utils.get_named_children(function_node)
      local transformed = ""
      for i, child in ipairs(children) do
        if i ~= 1 then
          transformed = string.format("%s\n    %s", transformed, vim.treesitter.get_node_text(child, bufnr))
        end
      end
      transformed = string.format("%s = begin\n%s\nend", call_expr, transformed)
      local transformed_lines = split_into_lines(transformed)
      local start_row, start_col, end_row, end_col = function_node:range()
      vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, transformed_lines)
    else
      local children = ts_utils.get_named_children(function_node)
      local transformed = ""
      for i, child in ipairs(children) do
        if i ~= 1 then
          transformed = string.format("%s", vim.treesitter.get_node_text(child, bufnr))
        end
      end
      transformed = string.format("%s = %s", call_expr, transformed)
      local transformed_lines = split_into_lines(transformed)
      local start_row, start_col, end_row, end_col = function_node:range()
      vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, transformed_lines)
    end
  else
    vim.notify("JuliaLongToShortFunctionAction can only be performed on long functions.", vim.log.levels.ERROR)
  end
end

local function _get_parent_assignment_node(bufnr)
  local node = ts_utils.get_node_at_cursor()
  while node do
    if node:type() == "assignment" then
      local op_node = node:named_child(1)
      if
        op_node
        and vim.treesitter.get_node_text(op_node, bufnr) == "="
        and node:named_child(0):type() == "call_expression"
      then
        break
      else
        node = node:parent()
      end
    else
      node = node:parent()
    end
  end
  if node == nil then
    return nil
  end

  return node
end

M.short_to_long_function = function()
  local bufnr = vim.api.nvim_get_current_buf()

  local assignment_node = _get_parent_assignment_node(bufnr)

  if assignment_node then
    local call_expr = vim.treesitter.get_node_text(assignment_node:named_child(0), bufnr)
    local body = vim.treesitter.get_node_text(assignment_node:named_child(2), bufnr)

    if vim.startswith(body, "begin") then
      local compound_statement = assignment_node:named_child(2)
      local children = ts_utils.get_named_children(compound_statement)
      local transformed_lines = { string.format("function %s", call_expr) }
      for _, child in ipairs(children) do
        local lines = split_into_lines(vim.treesitter.get_node_text(child, bufnr))
        for _, line in ipairs(lines) do
          transformed_lines[#transformed_lines + 1] = string.format("    %s", line)
        end
      end
      transformed_lines[#transformed_lines + 1] = "end"
      -- Replace the function definition in the buffer with the transformed version
      local start_row, start_col, end_row, end_col = assignment_node:range()
      vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, transformed_lines)
    else
      local transformed = string.format("function %s\n  %s\nend", call_expr, body)
      local transformed_lines = split_into_lines(transformed)

      -- Replace the function definition in the buffer with the transformed version
      local start_row, start_col, end_row, end_col = assignment_node:range()
      vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, transformed_lines)
    end
  else
    vim.notify("JuliaShortToLongFunctionAction can only be performed on short functions.", vim.log.levels.ERROR)
  end
end

return M
