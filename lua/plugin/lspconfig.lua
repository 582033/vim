-- lsp diagnostic
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with( vim.lsp.diagnostic.on_publish_diagnostics, {
	-- Enable underline, use default values
	underline = true,
	-- Enable virtual text, override spacing to 2
	virtual_text = {
		spacing = 2,
		-- Could be '●', '▎', 'x', '<'
		prefix = '■',
	},
	-- Use a function to dynamically turn signs off
	-- and on, using buffer local variables
	-- [[
	signs = function(bufnr, client_id)
		local ok, result = pcall(vim.api.nvim_buf_get_var, bufnr, 'show_signs')
		-- No buffer local variable set, so just enable by default
		if not ok then
			return true
		end

		return result
	end,
	--]]
	signs = true,
	-- Disable a feature
	update_in_insert = false,
})


-- cmp 配置
local cmp = require'cmp'
local types = require("cmp.types")
local str = require("cmp.utils.str")


local lspkind = require("lspkind")
cmp.setup {
	-- completion = { border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, scrollbar = "║" },
	-- documentation = {
	-- 	border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
	-- 	scrollbar = "║",
	-- },
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},

	-- 配置补全内容来源
	sources = cmp.config.sources {
		-- 支持从打开的文件中补全内容
		{ name = 'buffer', option = { get_bufnrs = vim.api.nvim_list_bufs } },
		-- 支持从 lsp 服务补全
		{ name = 'nvim_lsp' },
		-- 支持补全文件路径
		{ name = 'path' },
		{ name = 'vsnip' }
	},

	formatting = {
		fields = {
			cmp.ItemField.Kind,
			cmp.ItemField.Abbr,
			cmp.ItemField.Menu,
		},
		format = lspkind.cmp_format({
			with_text = false,
			before = function(entry, vim_item)
				-- 提示来源
				-- vim_item.menu = "["..string.upper(entry.source.name).."]"
				--
				-- Get the full snippet (and only keep first line)
				local word = entry:get_insert_text()
				if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
					word = vim.lsp.util.parse_snippet(word)
				end
				word = str.oneline(word)

				-- concatenates the string
				-- local max = 50
				-- if string.len(word) >= max then
				-- 	local before = string.sub(word, 1, math.floor((max - 3) / 2))
				-- 	word = before .. "..."
				-- end

				if
					entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet
					and string.sub(vim_item.abbr, -1, -1) == "~"
				then
						word = word .. "~"
				end
				vim_item.abbr = word

				return vim_item
			end,
		}),
	},
	snippet = {
		expand = function(args) 
			vim.fn['vsnip#anonymous'](args.body) 
		end,
	},
	-- 映射按键
	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		['<C-j>'] = cmp.mapping.scroll_docs(-4),
		['<C-k>'] = cmp.mapping.scroll_docs(4),
		--["<C-Space>"] = cmp.mapping.complete({ reason = cmp.ContextReason.{Manual,Auto} })),
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true
		},
	},
}
-- cmp 关联lsp
capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

--capabilities.textDocument.completion.completionItem.snippetSupport = true
--capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require'lspconfig'.gopls.setup {
	-- on_attach 表示当前缓冲加载服务端完成之后调用
	on_attach = function(client, bufnr)
		-- 为方便使用，定义了两个工具函数
		local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
		local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

		-- 配置标准补全快捷键
		-- 在插入模式可以按 <c-x><c-o> 触发补全
		buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

		local opts = { noremap=true, silent=true }

		-- 设置 normal 模式下的快捷键
		-- 第一个参数 n 表示 normal 模式
		-- 第二个参数表示按键
		buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
		-- 跳转到定义或者声明的地方
		buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
		buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
		-- 查看接口的所有实现
		buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
		-- 查看所有引用当前对象的地方
		buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
		-- 跳转到下一个/上一个语法错误
		buf_set_keymap('n', 'sp', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
		buf_set_keymap('n', 'sn', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
		buf_set_keymap('n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
		-- 手工触发格式化
		buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
		buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
		buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
		buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', opts)
		-- 列出所有语法错误列表
		buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', opts)
		-- 修改当前符号的名字
		buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
		buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', opts)
		buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', opts)
		buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', opts)
	end,
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 150,
	},
}

--require('plugin.snippets')
