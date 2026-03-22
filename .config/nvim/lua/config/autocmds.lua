local augroup = vim.api.nvim_create_augroup("cte_nvim", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  desc = "Highlight on yank",
  callback = function()
    vim.highlight.on_yank({ timeout = 180 })
  end,
})
