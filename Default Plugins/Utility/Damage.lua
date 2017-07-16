--[[
	  ____                      _       _           _       
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/                                                                                         
	               
	@Description: SyncAdmin plugin command to remove a set amount of health from the selected player.
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
--]]

local command = {}
command.PermissionLevel = 1
command.Shorthand = nil
command.Params = {"PlayerList","Number"}
command.Usage = "heal Player1,Player2,Player3,... Amount"
command.Description = [[Damages the users by the given amount]] 

command.Init = function(main)
end

command.Run = function(main,user,users,amount)
	if (amount < 0) then
		return false,"Cannot damage by negative amount"
	end
	
	local list = {}
	for _,player in pairs(users) do
		if (player.Character and player.Character:FindFirstChild("Humanoid")) then
			local hum = player.Character.Humanoid
			hum.Health = hum.Health - amount
		end
		table.insert(list,player.Name)
	end
	
	return true,"Damaged users " .. table.concat(list,", ") .. " by " .. amount .. " health",
		list,user.Name .. " has damaged you by " .. amount .. " health"
end

return command
