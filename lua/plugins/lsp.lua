return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          mason = false,
          cmd = { "lua-language-server" },
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        },
        clangd = {
          mason = false,
          cmd = { "clangd", "--background-index", "--clang-tidy" },
        },
        kotlin_language_server = {
          mason = true,         init_options = {
            storagePath = vim.fn.stdpath("cache") .. "/kotlin_language_server"
          },
        },
      },
    },
  },
}
