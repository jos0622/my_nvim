return {
	{ "folke/todo-comments.nvim", opts = {} },
	{
    		"nvim-treesitter/nvim-treesitter",
    		build = {":TSUpdate", ":TSEnable highlight",}
	},
	{
        "sontungexpt/witch",
        priority = 1000,
        lazy = false,
        config = function(_, opts)
            require("witch").setup(opts)
        end,
  	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	{"nvim-neotest/neotest-python"}
}
