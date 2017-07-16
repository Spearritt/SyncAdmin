local command = {}
command.PermissionLevel = 1
command.Shorthand = "sgod"
command.Params = {"Optional:PlayerList"}
command.Usage = "god [Player1,Player2,Player3,...] [Duration]"
command.Description = [[Gives the specified players silent god mode. If no players
are specified, it will give silent god mode to you.]] 

command.Init = function(main)
end

command.Run = function(main,user,users)
	if (users == nil or #users == 0) then users = {user} end
	local list = {}
	
	for _,player in pairs(users) do
		if player.Character then
			player.Character.Humanoid.MaxHealth = "1.797693e308" -- Range maximum for double precision floating point number is '1.8e308' however, this retuns math.huge
			player.Character.Humanoid.Health = "1.797693e308" -- so we're using 1.797693e308 instead to give the user a large amount of health without it being noticed.
			table.insert(list,player.Name)
		end
	end
	
	return true,"Given silent god mode to: " .. table.concat(list,",") .. ".",list,user.Name .. " has given you silent god mode."
end

return command
