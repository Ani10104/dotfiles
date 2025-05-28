return{
	'L3MON4D3/LuaSnip',
	event = { 'BufReadPre', 'BufNewFile' },
	config = function ()
		require 'ani.snippets.environments'
		-- require 'ani.snippets.template'
		-- require 'ani.snippets.env'
		-- require 'ani.snippets.math'
		--require('luasnip.loaders.from_snipmate').load { paths = '~/.config/nvim/snippets/' }

	end
}
