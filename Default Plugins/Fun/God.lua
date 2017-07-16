--[[
	  ____                      _       _           _       
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/                                                                                         
	               
	@Description: SyncAdmin plugin command to give the selected player god mode.
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
--]]

local command = {}
command.PermissionLevel = 1
command.Shorthand = nil
command.Params = {"Optional:PlayerList"}
command.Usage = "god [Player1,Player2,Player3,...] [Duration]"
command.Description = [[Gives the specified players god mode. If no players
are specified, it will give a god mode to you. Will
accept multiple players separated by commas.]] 

command.Init = function(main)
end

command.Run = function(main,user,users)
	if (users == nil or #users == 0) then users = {user} end
	local list = {}
	
	for _,player in pairs(users) do
		if player.Character then
			player.Character.Humanoid.MaxHealth = math.huge
			table.insert(list,player.Name)
		end
	end
	
	return true,"Given god mode to: " .. table.concat(list,",") .. ".",list,user.Name .. " has given you god mode."
end

return command
