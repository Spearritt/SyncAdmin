--[[
	  ____                      _       _           _       
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/                                                                                         
	               
	@Description: SyncAdmin plugin command to send a message to all users in game.
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
--]]

local command = {}
command.PermissionLevel = 2
command.Shorthand = "sm"
command.Params = {"..."}
command.Usage = "systemmmessage Your text here"
command.Description = [[Displays the given message to all users anonymously.]] 

local rstore = game:GetService("ReplicatedStorage")
command.Init = function(main)
end

command.Run = function(main,user,...)
	local message = game:GetService("Chat"):FilterStringForBroadcast(table.concat({...}," "),user)
	local list = {}
	for _,player in pairs(game:GetService("Players"):GetPlayers()) do
		SyncAPI.DisplayMessage(player,"SYSTEM MESSAGE",message)
		table.insert(list,player.Name)
	end
	return true,"Shown system message to users: " .. table.concat(list,", ")
end

return command
