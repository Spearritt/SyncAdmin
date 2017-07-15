--[[
	  ____                      _       _           _       
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/                                                                                         
	               
	@Description: SyncAdmin plugin to view all banned users in your game via SyncAdmin
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
--]]

local command = {}
command.PermissionLevel = 1
command.Shorthand = {"banlist","banned"}
command.Params = {}
command.Usage = "bannedlist"
command.Description = [[Display the banned users list.]] 

command.Init = function(main)
end

command.Run = function(main,user)
	local message = "Banned Users List\n"
	for _,b in pairs(SyncAPI.GetBannedUsers()) do message = message .. b.Username .. ": " .. b.UserId .. "\n" end
	SyncAPI.DisplayScrollMessage(user,"BANNED LIST",message)
	return true,"Loaded the ban list."
end

return command