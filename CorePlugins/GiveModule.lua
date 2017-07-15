local command = {}
command.PermissionLevel = 3
command.Shorthand = "mgive"
command.Params = {"PlayerList","String"}
command.Usage = "givetools Player1,Player2,Player3,... id1,id2,id3..."
command.Description = [[Gives the selected player a tool via ModuleScript.]] 


function strSplit(inputstr,sep)
	local t,i = {},1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end


command.Init = function(main)
end

command.Run = function(main,user,users,tools)
	local list = {}
	local ids = strSplit(tools,",")
	for _,player in pairs(users) do
		for _,id in pairs(ids) do
			require(tonumber(id))(player)
		end
		table.insert(list,player.Name)
	end
	return true,"Given the specified tools to users: " .. table.concat(list,", "),list,user.Name .. " has given you tools."
end

return command
