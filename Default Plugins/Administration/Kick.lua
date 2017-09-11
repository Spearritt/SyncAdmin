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
command.Params = {"PlayerList","..."}
command.Usage = "kick Player Reason"
command.Description = [[Kicks the player and displays the reason in the kick message.]]

command.Init = function(main)
end

command.Run = function(main,user,players,...)
	if (user == nil) then error("No user found") end
	local reason = game:GetService("Chat"):FilterStringForBroadcast(table.concat({...}," "),user)
	
	local list = {}
	for _,player in pairs(players) do
		if SyncAPI.GetPermissionLevel(user) >= SyncAPI.GetPermissionLevel(player) then
			table.insert(list,player.Name)
			player:Kick(reason)
		else
			return false,"You cannot run this command on someone with a higher or permission level than you."
		end
	end
	
	return true,"Kicked users: " .. table.concat(list) .. " for reason '" .. reason .. "'" 
end

return command
