local command = {}
command.PermissionLevel = 1
command.Shorthand = {"clearinv","cleartools"}
command.Params = {"Optional:PlayerList"}
command.Usage = "removetools Player"
command.Description = [[Removes tools from the selelcted players]] 

command.Init = function(main)
end

command.Run = function(main,user,users)
	if (users == nil or #users == 0) then
		users = {user}
	end
	
	local list = {}
	for _,player in pairs(users) do
		player.Backpack:ClearAllChildren()
		table.insert(list,player.Name)
	end
	return true,"Removed tools from: " .. table.concat(list,",") .. ".",list,user.Name .. " has removed your tools."
end

return command
