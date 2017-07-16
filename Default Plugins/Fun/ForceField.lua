--[[
	  ____                      _       _           _       
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/                                                                                         
	               
	@Description: SyncAdmin plugin command to create a force field for the selected user.
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
--]]

local command = {}
command.PermissionLevel = 1
command.Shorthand = "ff"
command.Params = {"Optional:PlayerList","Optional:Number"}
command.Usage = "forcefield [Player1,Player2,Player3,...] [Duration]"
command.Description = [[Gives the specified players forcefields. If no players
are specified, it will give a forcefield to you. Will
accept multiple players separated by commas.]] 

command.Init = function(main)
end

command.Run = function(main,user,users,duration)
	if (users == nil or #users == 0) then users = {user} end
	local list = {}
	for _,player in pairs(users) do
		local ff = Instance.new("ForceField",player.Character)
		
		if (duration) then
			local d = game:GetService("Debris")
			d:AddItem(ff,duration)
		end
		
		table.insert(list,player.Name)
	end
	if (duration) then
		return true,"Given forcefields to: " .. table.concat(list,",") .. " for " .. duration .. " seconds.",list,user.Name .. " has given you a forcefield for " .. duration " seconds."
	else
		return true,"Given forcefields to: " .. table.concat(list,",") .. ".",list,user.Name .. " has given you a forcefield."
	end
end

return command
