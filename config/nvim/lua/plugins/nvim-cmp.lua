-- nvim-cmp no longer used. blink.
if true then return {} end

return {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
        local cmp = require("cmp")

        opts.mapping = vim.tbl_extend("force", opts.mapping, {
            ["<Tab>"] = cmp.mapping(function(fallback)
                -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
                if cmp.visible() then
                    local entry = cmp.get_selected_entry()
                    if not entry then
                        cmp.select_next_item({
                            behavior = cmp.SelectBehavior.Select,
                        })
                    else
                        cmp.confirm()
                    end
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<CR>"] = cmp.mapping(function(fallback)
                cmp.abort()
                fallback()
            end, { "i", "s" }),
        })
    end,
}
