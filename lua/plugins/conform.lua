return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        stylua = {
          command = "stylua",
          prepend_args = { "--search-parent-directories", "--respect-ignores" },
        },
      },
    },
  },
}
