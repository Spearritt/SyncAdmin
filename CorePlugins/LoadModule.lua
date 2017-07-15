local command = {}
command.PermissionLevel = 3
command.Shorthand = nil
command.Params = {"Number","String","..."}
command.Usage = "loadmodule ModuleID [Function] [ValueType:Value] ..."
command.Description = [[Loads a ModuleScript by the given ID]] 

command.Init = function(main)
end

--// String Split function
function strSplit(inputstr,sep)
	local t,i = {},1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

--// String typecasts
local casts = {}

--// Cast to string
function casts.String(str)
	return tostring(str)
end

--// Cast to number
function casts.Number(str)
	return tonumber(str)
end

--// Cast to boolean
function casts.Boolean(str)
	if (str == "true") then
		return true
	elseif (str == "false") then
		return false
	else
		error("Boolean must be true or false")
	end
end

--// Cast to nil
function casts.Nil(str)
	return nil
end

--// Cast to Instance
function casts.Instance(str)
	local inst = game
	local params = strSplit(str,".")
	
	for _,param in pairs(params) do
		inst = inst[param]
	end
	
	return inst
end

--// Cast to BrickColor
function casts.BrickColor(str)
	local str = string.gsub(str,"-"," ")
	return BrickColor.new(str)
end

--// Cast to Color3
function casts.Color3(str)
	local v = strSplit(str,",")
	return Color3.new(v[1],v[2],v[3])
end

--// Cast to Vector3
function casts.Vector3(str)
	local v = strSplit(str,",")
	return Vector3.new(v[1],v[2],v[3])
end

--// Cast to CFrame
function casts.CFrame(str)
	local v = strSplit(str,",")
	return CFrame.new(unpack(v))
end

command.Run = function(main,user,id,func,...)
	if (id ~= nil) then
		if (func == nil) then
			require(id)()
		else
			local module = require(id)
			if (func == ".def") then
				func = module
			else
				func = module[func]
			end
			
			local values = {...}
			local parameters = {}
			for _,v in pairs(values) do
				local s = strSplit(v,":")
				if (s[1] and s[2]) then
					table.insert(parameters,casts[s[1]](s[2]))
				end
			end
			
			spawn(function()
				func(unpack(parameters))
			end)
		end
		return true,"Module was loaded!"
	else
		return false,"No ID specified!"
	end
end

return command
