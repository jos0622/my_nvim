-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.relativenumber = true

-- set tabulation
vim.opt.tabstop = 4      -- Número de espacios que representa un tab
vim.opt.shiftwidth = 4   -- Tamaño de indentación automática
vim.opt.expandtab = true -- Convierte tabs a espacios





vim.api.nvim_create_autocmd("FileType", {
    pattern = { "javascript", "typescript" }, -- Aplica estas configuraciones solo para archivos Python
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.expandtab = true
    end,
})


vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp", { clear = true }),
    callback = function(args)
        -- 2
        vim.api.nvim_create_autocmd("BufWritePre", {
            -- 3
            buffer = args.buf,
            callback = function()
                vim.lsp.buf.format { async = false, id = args.data.client_id }
                vim.lsp.buf.code_action({
                  context = { only = { "source.fixAll" } },
                  apply = true,
                })
            end,
        })
    end
})


vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {

    pattern = "python",
    callback = function(ev)
        print(string.format('event fired: %s', vim.inspect(ev)))
    end
})

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "nightfox" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})




vim.cmd("colorscheme nightfox")
