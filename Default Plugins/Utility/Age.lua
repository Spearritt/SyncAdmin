--[[
	  ____                      _       _           _       
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/                                                                                         
	               
	@Description: SyncAdmin plugin command to view the selected players account age.
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
--]]

local command = {}
command.PermissionLevel = 1
command.Shorthand = {"plrage","playerage"}
command.Params = {"Optional:Player"}
command.Usage = "age Player"
command.Description = [[Views the account age of a player.]] 

command.Init = function(main)
end

command.Run = function(main,user,player)
	if (player) then
		return true,"The age of " .. player.Name .. "'s account is " .. player.AccountAge .. " days old."
	else
		return true,"Your account is " .. user.AccountAge .. " days old"
	end
end

return command
