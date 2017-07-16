--[[
	  ____                      _       _           _       
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/                                                                                         
	               
	@Description: SyncAdmin plugin command to make the selected user jump.
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
--]]

local command = {}
command.PermissionLevel = 1
command.Shorthand = nil
command.Params = {"Optional:PlayerList"}
command.Usage = "jump Player"
command.Description = [[Jump a player.]] 

command.Init = function(main)
end

command.Run = function(main,user,users,...)
	if (user == nil) then error("No user found") end
	if (users == nil or #users == 0) then users = {user} end
	
	local list = {}
	for _,player in pairs(users) do
		table.insert(list,player.Name)
		local char = player.Character
		player.Character.Humanoid.Jump = true
	end
	return true,"Jumped players: " .. table.concat(list),list,user.Name .. " has made your character jump."
end

return command
