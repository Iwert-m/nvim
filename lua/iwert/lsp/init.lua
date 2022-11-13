local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "iwert.lsp.mason"
require("iwert.lsp.handlers").setup()
require "iwert.lsp.null-ls"
