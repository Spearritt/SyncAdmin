--[[
	  ____                      _       _           _       
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/                                                                                         
	               
	@Description: SyncAdmin plugin command to kick users from your game.
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
--]]

local command = {}
command.PermissionLevel = 1
command.Shorthand = nil
command.Params = {"PlayerList"}
command.Usage = "unsetperms Player"
command.Description = [[Removes the "temporary permission level" lock and allows the admin system to automatically control these peoples' permission levels.]]

command.Init = function(main)
end

command.Run = function(main,user,players,...)
	if (user == nil) then error("No user found") end
	local reason = table.concat({...}," ")
	
	local list = {}
	for _,player in pairs(players) do
		if SyncAPI.GetPermissionLevel(user) >= SyncAPI.GetPermissionLevel(player) or (player.UserId == game.CreatorId) then
			table.insert(list,player.Name)
			
			SyncAPI.SetPermissionLevelAuto(player)
		else
			return false,"You cannot run this command on someone with a higher permission level than you."
		end
	end
	
	return true,"Unset these players' permissions: " .. table.concat(list,", ")
end

return command
