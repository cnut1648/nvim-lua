-----------------------------------------------------------
-- Autocomplete configuration file
-----------------------------------------------------------

-- Plugin: nvim-cmp
-- url: https://github.com/hrsh7th/nvim-cmp

local cmp_status_ok, cmp = pcall(require, 'cmp')
if not cmp_status_ok then
  return
end

local ultisnip_status_ok, cmp_ultisnips_mappings= pcall(require, 'cmp_nvim_ultisnips.mappings')
if not ultisnip_status_ok then
  return
end

cmp.setup {
  -- Load snippet support
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },

-- Completion settings
  completion = {
    --completeopt = 'menu,menuone,noselect'
    keyword_length = 2
  },

  -- Key mapping
  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },

    -- Tab mapping
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
      end
    end, {"i", "s"}),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        cmp_ultisnips_mappings.jump_backwards(fallback)
      end
    end, {"i", "s"}),
  },

  -- Load sources, see: https://github.com/topics/nvim-cmp
  sources = {
    { name = 'nvim_lsp' },
    { name = 'ultisnips' },
    { name = 'path' },
    { name = 'buffer' },
  },
}
