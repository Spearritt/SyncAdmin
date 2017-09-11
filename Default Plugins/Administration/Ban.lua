--[[
	  ____                      _       _           _       
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/                                                                                         
	               
	@Description: SyncAdmin plugin to ban users from your game
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
--]]

local command = {}
command.PermissionLevel = 2
command.Shorthand = {"banish"}
command.Params = {"SafePlayer","..."}
command.Usage = "ban Player Reason"
command.Description = [[Bans the player and displays the reason in the initial kick message.]] 

command.Init = function(main)	
end

command.Run = function(main,user,player,...)
	if (SyncAPI.GetPermissionLevel(user) >= SyncAPI.GetPermissionLevel(player)) then
		if (user == nil) then error("No user found") end	
		local reason = game:GetService("Chat"):FilterStringForBroadcast(table.concat({...}," "),user)
		
		SyncAPI.Ban(player,reason,0,true)
		
		return true,"Banned user " .. player.Name .. " for reason '" .. reason .. "'"
	else
		return false,"You cannot run this command on someone with a higher or the same permission level than you."
	end
	
end

return command
