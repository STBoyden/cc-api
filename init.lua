local modname = ...

local cc_api = {}
cc_api.net = require(modname .. ".net")
cc_api.ui = require(modname .. ".ui")

return cc_api