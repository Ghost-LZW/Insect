local socket = require 'socket'
local Handler = require 'insect.handler'

local Insect = {}
Insect.__index = Insect

function Insect:new( params )
	params = params or {}
	local server = {}

	server.host = params.host or '*'
	server.port = params.port or '8888'
	server.location = params.location or ''
	server.plugins = params.plugins or {}
	server.timeout = params.timeout or 1

	return setmetatable(server, self)
end

function Insect:start( callback )
	local handler = Handler:new(self.location, self.plugins, callback);
	local server = assert(socket.bind(self.host, self.port))
	local ip, port = server:getsockname();
	print('Insect already up on ' .. ip .. ':' .. port)

	while true do
		local client = server:accept()
		client:settimeout(self.timeout, 'b')
		handler:processRequest(self.port, client)
	end
end

return Insect