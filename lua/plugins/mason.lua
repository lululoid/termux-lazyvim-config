return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      -- Remove stylua from the ensure_installed list
      opts.ensure_installed = vim.tbl_filter(function(v)
        return v ~= "stylua"
      end, opts.ensure_installed or {})
    end,
  },
}
