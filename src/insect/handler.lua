local Request = require 'insect.request'
local Response = require 'insect.response'
local lfs = require 'lfs'
local mimetypes = require 'mimetypes'

local Handler = {}
Handler.__index = Handler

function Handler:new( location, plugins, callback )
	local handler = {}
	handler.location = location or ''
	handler.plugins = plugins or {}
	handler.callback = callback

	return setmetatable(handler, self)
end

function Handler:processRequest(port, client)
	local request = Request:new(port, client)

	if not request:method() then
		client:close()
		return
	end

	local response = Response:new(client)

	local path
	if request:path() and self.location ~= '' then
		if request:path() == '/' or request:path() == '' then
			path = 'index.html'
		else
			path = request:path()
		end

		local filename = '.' .. self.location .. path

		if not lfs.attributes(filename) then
			response:statuCode(404)
		end

		local file = io.open(filename, 'rb')

		if file then
			response:writeFile(file, mimetypes.guess(filename or '') or 'text/html')
		else
			response:statuCode(404)
		end
	end

	if response.statu == 404 then
		response:writeDefaultErrorMessage(404)
	end
end

return Handler