-----------------------------------------------------------
-- Neovim navic configuration file
-----------------------------------------------------------

-- Plugin: nvim-navic
-- url: https://github.com/SmiteshP/nvim-navic

local lsp_status_ok, lspconfig = pcall(require, 'lspconfig')
if not lsp_status_ok then
  return
end

local navic_status_ok, navic = pcall(require, 'navic')
if not navic_status_ok then
  return
end

local feline_status_ok, feline = pcall(require, 'feline')
if not navic_status_ok then
  return
end

require("lspconfig").pyright.setup {
    on_attach = function(client, bufnr)
        navic.attach(client, bufnr)
    end
}
navic.setup {
    icons = {
        File          = " ",
        Module        = " ",
        Namespace     = " ",
        Package       = " ",
        Class         = " ",
        Method        = " ",
        Property      = " ",
        Field         = " ",
        Constructor   = " ",
        Enum          = "練",
        Interface     = "練",
        Function      = " ",
        Variable      = " ",
        Constant      = " ",
        String        = " ",
        Number        = " ",
        Boolean       = "◩ ",
        Array         = " ",
        Object        = " ",
        Key           = " ",
        Null          = "ﳠ ",
        EnumMember    = " ",
        Struct        = " ",
        Event         = " ",
        Operator      = " ",
        TypeParameter = " ",
    },
    highlight = false,
    separator = " > ",
    depth_limit = 0,
    depth_limit_indicator = "..",
}
