package.path = "../src/?.lua;../src/?/init.lua;" .. package.path

local Insect = require 'insect'

local server = Insect:new({
	port='6060',
	location='/res/'
})

server:start()