--[[
	  ____                      _       _           _       
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/                                                                                         
	               
	@Description: SyncAdmin plugin command to remove the selected players force field.
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
--]]

local command = {}
command.PermissionLevel = 1
command.Shorthand = "unff"
command.Params = {"Optional:PlayerList"}
command.Usage = "unforcefield [Player1,Player2,Player3,...]"
command.Description = [[Removes any forcefields from the specified players. If no
players are specified, it will remove yours. Will
accept multiple players separated by commas.]] 

command.Init = function(main)
end

command.Run = function(main,user,users)
	if (users == nil) then users = {user} end
	local list = {}
	for _,player in pairs(users) do
		table.insert(list,player.Name)
		
		if (player.Character) then
			for _,a in pairs(player.Character:children()) do
				if (a:IsA("ForceField")) then a:Destroy() end
			end
		end
	end
	return true,"Taken forcefields from: " .. table.concat(list,", "),list,user.Name .. " has removed your forcefield."
end

return command
