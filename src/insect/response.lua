local STATUS_CODE = {
	[99] = '客户端应当继续发送请求。',
	[100] =	'服务器已经理解了客户端的请求，并将通过Upgrade 消息头通知客户端采用不同的协议来完成这个请求。在发送完这个响应最后的空行后，服务器将会切换到在Upgrade 消息头中定义的那些协议。',
	[101] =	'由WebDAV（RFC 2518）扩展的状态码，代表处理将被继续执行。',
	[199] =	'请求已成功，请求所希望的响应头或数据体将随此响应返回。',
	[200] =	"请求已经被实现，而且有一个新的资源已经依据请求的需要而建立，且其 URI 已经随Location 头信息返回。假如需要的资源无法及时建立的话，应当返回 '202 Accepted'。",
	[201] =	'服务器已接受请求，但尚未处理。正如它可能被拒绝一样，最终该请求可能会也可能不会被执行。在异步操作的场合下，没有比发送这个状态码更方便的做法了。',
	[202] =	'服务器已成功处理了请求，但返回的实体头部元信息不是在原始服务器上有效的确定集合，而是来自本地或者第三方的拷贝。当前的信息可能是原始版本的子集或者超集。',
	[204] =	'服务器成功处理了请求，但不需要返回任何实体内容，并且希望返回更新了的元信息。响应可能通过实体头部的形式，返回新的或更新后的元信息。',
	[205] =	'服务器成功处理了请求，且没有返回任何内容。但是与204响应不同，返回此状态码的响应要求请求者重置文档视图。',
	[206] =	'服务器已经成功处理了部分 GET 请求。',
	[207] =	'由WebDAV(RFC 2518)扩展的状态码，代表之后的消息体将是一个XML消息，并且可能依照之前子请求数量的不同，包含一系列独立的响应代码。',
	[300] =	'被请求的资源有一系列可供选择的回馈信息，每个都有自己特定的地址和浏览器驱动的商议信息。',
	[301] =	'被请求的资源已永久移动到新位置，并且将来任何对此资源的引用都应该使用本响应返回的若干个 URI 之一。',
	[302] =	'请求的资源现在临时从不同的 URI 响应请求。',
	[303] =	'对应当前请求的响应可以在另一个 URI 上被找到，而且客户端应当采用 GET 的方式访问那个资源。',
	[304] =	'如果客户端发送了一个带条件的 GET 请求且该请求已被允许，而文档的内容（自上次访问以来或者根据请求的条件）并没有改变.',
	[305] =	'被请求的资源必须通过指定的代理才能被访问。Location 域中将给出指定的代理所在的 URI 信息，接收者需要重复发送一个单独的请求，通过这个代理才能访问相应资源。只有原始服务器才能建立305响应。',
	[306] =	'在最新版的规范中，306状态码已经不再被使用。',
	[307] =	'请求的资源现在临时从不同的URI 响应请求。由于这样的重定向是临时的，客户端应当继续向原有地址发送以后的请求。只有在Cache-Control或Expires中进行了指定的情况下，这个响应才是可缓存的。',
	[400] =	'1、语义有误，当前请求无法被服务器理解。除非进行修改，否则客户端不应该重复提交这个请求。 　　2、请求参数有误。',
	[401] =	'当前请求需要用户验证。该响应必须包含一个适用于被请求资源的 WWW-Authenticate 信息头用以询问用户信息。客户端可以重复提交一个包含恰当的 Authorization 头信息的请求。',
	[402] =	'该状态码是为了将来可能的需求而预留的。',
	[403] =	'服务器已经理解请求，但是拒绝执行它。与401响应不同的是，身份验证并不能提供任何帮助，而且这个请求也不应该被重复提交。',
	[404] =	'请求失败，请求所希望得到的资源未被在服务器上发现。没有信息能够告诉用户这个状况到底是暂时的还是永久的。',
	[405] =	'请求行中指定的请求方法不能被用于请求相应的资源。该响应必须返回一个Allow 头信息用以表示出当前资源能够接受的请求方法的列表。',
	[406] =	'请求的资源的内容特性无法满足请求头中的条件，因而无法生成响应实体。',
	[407] =	'与401响应类似，只不过客户端必须在代理服务器上进行身份验证。',
	[408] = '请求超时。客户端没有在服务器预备等待的时间内完成一个请求的发送。客户端可以随时再次提交这一请求而无需进行任何更改。',
	[409] = '由于和被请求的资源的当前状态之间存在冲突，请求无法完成。',
	[410] = "被请求的资源在服务器上已经不再可用，而且没有任何已知的转发地址。",
	[411] = '服务器拒绝在没有定义 Content-Length 头的情况下接受请求。在添加了表明请求消息体长度的有效 Content-Length 头之后，客户端可以再次提交该请求。',
	[412] = '服务器在验证在请求的头字段中给出先决条件时，没能满足其中的一个或多个。',
	[413] = '服务器拒绝处理当前请求，因为该请求提交的实体数据大小超过了服务器愿意或者能够处理的范围。',
	[414] = '请求的URI 长度超过了服务器能够解释的长度，因此服务器拒绝对该请求提供服务。',
	[415] = '对于当前请求的方法和所请求的资源，请求中提交的实体并不是服务器中所支持的格式，因此请求被拒绝。',
	[416] = '如果请求中包含了 Range 请求头，并且 Range 中指定的任何数据范围都与当前资源的可用范围不重合，同时请求中又没有定义 If-Range 请求头.',
	[417] = '在请求头 Expect 中指定的预期内容无法被服务器满足，或者这个服务器是一个代理服务器，它有明显的证据证明在当前路由的下一个节点上，Expect 的内容无法被满足。',
	[421] = '从当前客户端所在的IP地址到服务器的连接数超过了服务器许可的最大范围。通常，这里的IP地址指的是从服务器上看到的客户端地址（比如用户的网关或者代理服务器地址',
	[422] = '请求格式正确，但是由于含有语义错误，无法响应。（RFC 4918 WebDAV）423 Locked 　　当前资源被锁定。（RFC 4918 WebDAV）',
	[424] = '由于之前的某个请求发生的错误，导致当前请求失败，例如 PROPPATCH。（RFC 4918 WebDAV）',
	[425] = '在WebDav Advanced Collections 草案中定义，但是未出现在《WebDAV 顺序集协议》（RFC 3658）中。',
	[426] = '客户端应当切换到TLS/1.0。（RFC 2817）',
	[449] = '由微软扩展，代表请求应当在执行完适当的操作后进行重试。',
	[500] = '服务器遇到了一个未曾预料的状况，导致了它无法完成对请求的处理。一般来说，这个问题都会在服务器的程序码出错时出现。',
	[501] = '服务器不支持当前请求所需要的某个功能。当服务器无法识别请求的方法，并且无法支持其对任何资源的请求。',
	[502] = '作为网关或者代理工作的服务器尝试执行请求时，从上游服务器接收到无效的响应。',
	[503] = '由于临时的服务器维护或者过载，服务器当前无法处理请求。',
	[504] = '作为网关或者代理工作的服务器尝试执行请求时，未能及时从上游服务器（URI标识出的服务器，例如HTTP、FTP、LDAP）或者辅助服务器（例如DNS）收到响应。',
	[505] = '服务器不支持，或者拒绝支持在请求中使用的 HTTP 版本。这暗示着服务器不能或不愿使用与客户端相同的版本。响应中应当包含一个描述了为何版本不被支持以及服务器支持哪些协议的实体。',
	[506] = '由《透明内容协商协议》（RFC 2295）扩展，代表服务器存在内部配置错误：被请求的协商变元资源被配置为在透明内容协商中使用自己，因此在一个协商处理中不是一个合适的重点。',
	[507] = '服务器无法存储完成请求所必须的内容。这个状况被认为是临时的。WebDAV (RFC 4918)',
	[509] = '服务器达到带宽限制。这不是一个官方的状态码，但是仍被广泛使用。',
	[510] = '获取资源所需要的策略并没有没满足。（RFC 2774)'
}

local DEFAULT_ERROR_MESSAGE = [[
  <!DOCTYPE HTML>
  <html lang='zh'>
  <head>
      <meta http-equiv='Content-Type' content='text/html;charset=utf-8'>
      <title>Error response</title>
  </head>
  <body>
      <h1>Error response</h1>
      <p>Error code: {{ STATUS_CODE }}</p>
      <p>Message: {{ STATUS_TEXT }}</p>
  </body>
  </html>
]]

local Response = {}
Response.__index = Response

function Response:new(client)
	local newJob = {}
	newJob.client = client
	newJob.statu = 200
	newJob.templateFirstLine = 'HTTP/1.1 {{ STATUS_CODE }} {{ STATUS_TEXT }}\r\n'
	newJob.headerFirstLine = ''
	newJob.headers = {}
	newJob.headerSended = false

	return setmetatable(newJob, self)
end

function Response:statuCode(code, codetext)
	self.statu = code
	self.headerFirstLine = string.gsub(self.templateFirstLine, '{{ STATUS_CODE }}', code)
	self.headerFirstLine = string.gsub(self.headerFirstLine, '{{ STATUS_TEXT }}', codetext or STATUS_CODE[code])

	return self
end

function Response:contentType(value)
  self.headers['Content-Type'] = value
  return self
end

function Response:writeDefaultErrorMessage(statusCode)
  self:statuCode(statusCode)
  local content = string.gsub(DEFAULT_ERROR_MESSAGE, '{{ STATUS_CODE }}', statusCode)
  self:write(string.gsub(content, '{{ STATUS_TEXT }}', STATUS_CODE[statusCode]))

  return self
end

function Response:_getHeaders()
  local headers = ''

  for key, value in pairs(self.headers) do
    headers = headers .. key .. ':' .. value .. '\r\n'
  end

  return headers
end

function Response:addHeader(key, value)
	self.headers[key] = value
	return self
end

function Response:sendHeader(data)
	if self.headerSended then
		return self
	end

	if type(data) == 'string' then
		self:addHeader('Content-Length', data:len())
	end

	self:addHeader('Date', os.date('!%a, %x', os.time()))

	if not self.headers['Content-Type'] then
		self:addHeader('Content-Type', 'text/html')
	end

	self.client:send(self.headerFirstLine .. self:_getHeaders())
	self.client:send('\r\n')
	self.headerSended = true

	return self
end

function Response:write(data)
	self:sendHeader(data)

	self.client:send(data)

	self.client:close()

	return self
end

function Response:writeFile(file, contype)
	self:contentType(contype)
	self:statuCode(200)
	local value = file:read('*a')
	file:close()
	self:write(value)

	return self
end

return Response
