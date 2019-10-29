local socket = require 'socket'

local Insect = {}

function Insect:new( params )
	params = params or {}
	local server = {}

	server.host = params.host or 'localhost'
	server.port = params.port or '8888'
	server.location = params.location or ''
	server.plugins = params.plugins
	server.timeout = params.timeout or 1

	return setmetatable(server, self)
end