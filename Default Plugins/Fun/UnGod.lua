--[[
	  ____                      _       _           _       
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/                                                                                         
	               
	@Description: SyncAdmin plugin command to remove the selected players god mode.
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
--]]

local command = {}
command.PermissionLevel = 1
command.Shorthand = nil
command.Params = {"Optional:PlayerList"}
command.Usage = "ungod [Player1,Player2,Player3,...] [Duration]"
command.Description = [[Removes the specified players god mode. If no players
are specified, it will remove god mode from you. Will
accept multiple players separated by commas.]] 

command.Init = function(main)
end

command.Run = function(main,user,users)
	if (users == nil) then users = {user} end
	local list = {}
	
	for _,player in pairs(users) do
		if player.Character then
			player.Character.Humanoid.MaxHealth = 100
			table.insert(list,player.Name)
		end
	end
	
	return true,"Removed god mode from: " .. table.concat(list,",") .. ".",list,user.Name .. " has removed your god mode."
end

return command
