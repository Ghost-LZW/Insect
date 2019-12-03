local function normalize(P)
  P = string.gsub(P, '\\',        '/')
  P = string.gsub(P, '^/*',       '/')
  P = string.gsub(P, '(/%.%.?)$', '%1/')
  P = string.gsub(P, '/%./',      '/')
  P = string.gsub(P, '/+',        '/')

  while true do
    local first, last = string.find(P, '/[^/]+/%.%./')
    if not first then break end
    P = string.sub(P, 1, first) .. string.sub(P, last + 1)
  end

  while true do
    local n
    P, n = string.gsub(P, '^/%.%.?/', '/')
    if n == 0 then break end
  end

  while true do
    local n
    P, n = string.gsub(P, '/%.%.?$', '/')
    if n == 0 then break end
  end

  return P
end

local Request = {}
Request.__index = Request

function Request:new(port, client)
	local NewJob = {}
	NewJob.port = port
	NewJob.client = client
	NewJob.ip = client:getpeername()
	NewJob.firstLine = nil
	NewJob._method = nil
	NewJob._path = ''
	NewJob._querryString = ''
	NewJob._params = {}
	NewJob._headers_parsed = false
	NewJob._headers = {}
	NewJob._content_length = 0
	NewJob._contest_done = 0

	return setmetatable(NewJob, self)
end

Request.PATTERN_METHOD = '^(.-)%s'
Request.PATTERN_PATH = '(%S+)%s*'
Request.PATTERN_PROTOCOL = '(HTTP%/%d%.%d)'
Request.PATTERN_REQUEST = (Request.PATTERN_METHOD ..
Request.PATTERN_PATH ..Request.PATTERN_PROTOCOL)
Request.PATTERN_QUERRY_STRING = '([^=]*)=([^&]*)&?'

function Request:getFirstLine()
	if self.firstLine ~= nil then
		return
	end

	local statu, partial
	self.firstLine, statu, partial = self.client:receive()

	if(self.firstLine == nil or statu == 'timeout' or statu == 'closed' or partial == '') then
		return
	end

	local method, path, protocol = string.match(self.firstLine,
												self.PATTERN_REQUEST)

	if not method then
		return
	end

	local filename, querryString
	if #path > 0 then
		filename, querryString = string.match(path, "^([^#?]+)[#|?]?(.*)")
		normalize(filename)
	else
		filename = ''
	end

	self._path = filename
	self._method = method
	self._querryString = querryString
end

function Request:parseUrlQuerry(value, _table)
	if value and next(_table) == nil then
		for k, v in string.gmatch(value, self.PATTERN_QUERRY_STRING) do
			_table[k] = v
		end
	end

	return _table
end

function Request:params()
	self:getFirstLine()
	return self:parseUrlQuerry(self._querryString, self._params)
end

function Request:method()
	self:getFirstLine()
	return self._method
end

function Request:path()
	self:getFirstLine()
	return self._path
end

Request.PATTERN_HEADER = '([%w-]+): ([%w %p]+=?)'

function Request:headers()
  if self._headers_parsed then
    return self._headers
  end

  self:parseFirstLine()

  local data = self.client:receive()

  while (data ~= nil) and (data:len() > 0) do
    local key, value = string.match(data, Request.PATTERN_HEADER)

    if key and value then
      self._headers[key] = value
    end

    data = self.client:receive()
  end

  self._headers_parsed = true
  self._content_length = tonumber(self._headers["Content-Length"] or 0)

  return self._headers
end

function Request:receiveBody(size)
  size = size or self._content_length

  if (self._content_length == nil) or (self._content_done >= self._content_length) then
    return false
  end

  local fetch = math.min(self._content_length - self._content_done, size)

  local data, err, partial = self.client:receive(fetch)

  if err == 'timeout' then
    data = partial
  end

  self._content_done = self._content_done + #data

  return data
end

return Request