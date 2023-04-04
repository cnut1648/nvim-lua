-----------------------------------------------------------
-- Neovim navic configuration file
-----------------------------------------------------------

-- Plugin: nvim-navic
-- url: https://github.com/SmiteshP/nvim-navic

local lsp_status_ok, lspconfig = pcall(require, 'lspconfig')
if not lsp_status_ok then
  return
end

local navic_status_ok, navic = pcall(require, 'nvim-navic')
if not navic_status_ok then
  return
end

local navbuddy_status_ok, navbuddy = pcall(require, 'nvim-navbuddy')
if not navbuddy_status_ok then
  return
end
local actions = require("nvim-navbuddy.actions")

local feline_status_ok, feline = pcall(require, 'feline')
if not navic_status_ok then
  return
end

-- must attach to lsp server
local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
for _, ls in ipairs(language_servers) do
  require("lspconfig")[ls].setup {
      on_attach = function(client, bufnr)
          navic.attach(client, bufnr)
          navbuddy.attach(client, bufnr)
      end
  }
end
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

navbuddy.setup {
    window = {
        border = "single",  -- "rounded", "double", "solid", "none"
                            -- or an array with eight chars building up the border in a clockwise fashion
                            -- starting with the top-left corner. eg: { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" }.
        size = "60%",
        position = "50%",
        scrolloff = nil,    -- scrolloff value within navbuddy window
        sections = {
            left = {
                size = "20%",
                border = nil, -- You can set border style for each section individually as well.
            },
            mid = {
                size = "40%",
                border = nil,
            },
            right = {
                -- No size option for right most section. It fills to
                -- remaining area.
                border = nil,
            }
        }
    },
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
    mappings = {
        ["<esc>"] = actions.close,        -- Close and cursor to original location
        ["q"] = actions.close,

        ["j"] = actions.next_sibling,     -- down
        ["k"] = actions.previous_sibling, -- up

        ["h"] = actions.parent,           -- Move to left panel
        ["l"] = actions.children,         -- Move to right panel

        ["v"] = actions.visual_name,      -- Visual selection of name
        ["V"] = actions.visual_scope,     -- Visual selection of scope

        ["y"] = actions.yank_name,        -- Yank the name to system clipboard "+
        ["Y"] = actions.yank_scope,       -- Yank the scope to system clipboard "+

        ["i"] = actions.insert_name,      -- Insert at start of name
        ["I"] = actions.insert_scope,     -- Insert at start of scope

        ["a"] = actions.append_name,      -- Insert at end of name
        ["A"] = actions.append_scope,     -- Insert at end of scope

        ["r"] = actions.rename,           -- Rename currently focused symbol

        ["d"] = actions.delete,           -- Delete scope

        ["f"] = actions.fold_create,      -- Create fold of current scope
        ["F"] = actions.fold_delete,      -- Delete fold of current scope

        ["c"] = actions.comment,          -- Comment out current scope

        ["<enter>"] = actions.select,     -- Goto selected symbol
        ["o"] = actions.select,

        ["J"] = actions.move_down,        -- Move focused node down
        ["K"] = actions.move_up,          -- Move focused node up
    },
    lsp = {
        auto_attach = false,   -- If set to true, you don't need to manually use attach function
        preference = nil,      -- list of lsp server names in order of preference
    },
    source_buffer = {
        follow_node = true,    -- Keep the current node in focus on the source buffer
        highlight = true,      -- Highlight the currently focused node
        reorient = "smart",    -- "smart", "top", "mid" or "none"
        scrolloff = nil        -- scrolloff value when navbuddy is open
    }
}
