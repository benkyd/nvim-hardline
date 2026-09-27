local fmt = string.format

local function get_diagnostic(prefix, severity)
  local severities = {
    ['Warning'] = vim.diagnostic.severity.WARN,
    ['Error'] = vim.diagnostic.severity.ERROR,
  }
  local count = #vim.diagnostic.get(0, {severity=severities[severity]})
  if count < 1 then
    return ''
  end
  return fmt('%s:%d', prefix, count)
end

local function get_error()
  return get_diagnostic('E', 'Error')
end

local function get_warning()
  return get_diagnostic('W', 'Warning')
end

local function get_lsp_clients()
  local clients = vim.lsp.get_clients({bufnr = 0})
  if #clients == 0 then
    return "none"
  end

  local c = {}
  for _, client in ipairs(clients) do
    table.insert(c, client.name)
  end
  return table.concat(c, "│")
end

return {
  get_error = get_error,
  get_warning = get_warning,
  get_lsp_clients = get_lsp_clients,
}
