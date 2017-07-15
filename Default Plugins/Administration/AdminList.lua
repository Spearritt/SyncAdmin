--[[
	  ____                      _       _           _       
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/                                                                                         
	               
	@Description: SyncAdmin plugin command to list all administrators on your game.
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
--]]

local command = {}
command.PermissionLevel = 1
command.Shorthand = "stafflist"
command.Params = {}
command.Usage = "adminlist"
command.Description = [[Display the admin list.]] 

command.Init = function(main)
end

command.Run = function(main,user)
	local message = "Moderator List\n"
	for _,b in pairs(SyncAPI.GetModList()) do message = message .. b.Username .. ": " .. b.UserId .. "\n" end
	message = message .. "\nAdministrator List\n"
	for _,b in pairs(SyncAPI.GetAdminList()) do message = message .. b.Username .. ": " .. b.UserId .. "\n" end
	message = message .. "\nSuper Administrator List\n"
	for _,b in pairs(SyncAPI.GetSuperAdminList()) do message = message .. b.Username .. ": " .. b.UserId .. "\n" end
	SyncAPI.DisplayScrollMessage(user,"ADMIN LIST",message)
	return true,"Loaded the admin list."
end

return command