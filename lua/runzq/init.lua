local M = {}

-- Default binary path
M.zq_path = "zq" -- fallback to the system default if not provided

-- Function to configure the zq binary path
function M.setup(opts)
	if opts and opts.zq_path then
		M.zq_path = opts.zq_path
	end
end

-- Function to run zq with current buffer content
M.run_zq_query = function()
	-- Get the current file path
	local current_file = vim.api.nvim_buf_get_name(0)

	if current_file == "" then
		print("No file is currently open")
		return
	end

	-- Check if the file has a .zed extension
	if not current_file:match("%.zed$") then
		print("The current file is not a .zed file")
		return
	end

	-- Construct the zq command
	local cmd = string.format("%s -z -I %s", M.zq_path, vim.fn.shellescape(current_file))

	-- Run the command using vim's terminal
	vim.cmd("split | terminal " .. cmd)
end

-- Function to print the zq command
M.print_zq_command = function()
	-- Get the current file path
	local current_file = vim.api.nvim_buf_get_name(0)

	if current_file == "" then
		print("No file is currently open")
		return
	end

	-- Check if the file has a .zed extension
	if not current_file:match("%.zed$") then
		print("The current file is not a .zed file")
		return
	end

	-- Construct the zq command
	local cmd = string.format("%s -z -I %s", M.zq_path, vim.fn.shellescape(current_file))

	-- Print the command so the user can copy it
	print("Command to run: " .. cmd)
end

-- Set up the user command to run zq query
vim.api.nvim_create_user_command("RunZq", function()
	M.run_zq_query()
end, {})

-- Set up the user command to print the zq command
vim.api.nvim_create_user_command("PrintZqCommand", function()
	M.print_zq_command()
end, {})

return M