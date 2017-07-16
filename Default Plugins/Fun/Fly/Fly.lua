--[[
	  ____                      _       _           _       
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/                                                                                         
	               
	@Description: SyncAdmin plugin command to make the selected user fly.
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
--]]

local command = {}
command.PermissionLevel = 1
command.Shorthand = nil
command.Params = {"PlayerList"}
command.Usage = "fly Player1,Player2,..."
command.Description = [[Allows the selected players to fly. Use X to toggle fly mode after using this command.]] 

command.Init = function(main)
end

command.Run = function(main,user,users)
	local list = {}
	for _,player in pairs(users) do
		local flyScript = script.SA_FlyScript:clone()
		flyScript.Disabled = false
		flyScript.Parent = player.Character
		table.insert(list,player.Name)
	end
	return true,"Made the following users fly: " .. table.concat(list,", "),list,user.Name .. " has made you fly, press X to toggle."
end

return command
