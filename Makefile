.SILENT:

install_dependence:
	luasocks install luacheck
	luasocks install socket
	luasocks install luafilesystem
	luasocks install mimetypes

check:
	luacheck res/insect