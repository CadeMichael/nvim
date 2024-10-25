local mappings = {
  ['@lsp.type.variable'] = 'Identifier',
}

for from, to in pairs(mappings) do
  vim.cmd.highlight('link ' .. from .. ' ' .. to)
end
