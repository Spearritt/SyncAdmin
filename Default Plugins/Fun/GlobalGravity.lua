--[[
	  ____                      _       _           _       
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/                                                                                         
	               
	@Description: SyncAdmin plugin command to change the gravity of the whole game.
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
--]]

local command = {}
command.PermissionLevel = 1
command.Shorthand = "grav"
command.Params = {"Number"}
command.Usage = "globalgravity Number"
command.Description = [[Changes the global game gravity]] 

command.Init = function()
end

command.Run = function(main,user,gravity)
	workspace.Gravity = gravity
	return true,"Set global game gravity to: " .. tostring(gravity) .. "."
end

return command
