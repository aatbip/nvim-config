return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    require("nvim-autopairs").setup({
      check_ts = true,                        -- use Treesitter for better pairing
      ts_config = {                           -- don't pair in certain nodes
        lua = { "string", "comment" },
        javascript = { "string", "template_string" },
      },
      disable_filetype = { "TelescopePrompt", "vim" },
      fast_wrap = {},                         -- <M-e> to wrap selection
    })

    -- This makes Enter + { } behave perfectly (new line + indent)
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
