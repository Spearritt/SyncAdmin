--[[
	  ____                      _       _           _       
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/                                                                                         
	               
	@Description: SyncAdmin plugin command to shutdown the game with a custom reason.
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
--]]

local command = {}
command.PermissionLevel = 2
command.Shorthand = nil
command.Params = {"..."}
command.Usage = "shutdown Reason"
command.Description = [[Kicks all players and forces the game to shut down.]] 

local isClosed = false
local sdReason = ""
command.Init = function(main)
	local players = game:GetService("Players")
	players.PlayerAdded:connect(function(player)
		if (isClosed) then
			player:Kick("SERVER SHUTTING DOWN\n\n" .. sdReason)
		end
	end)
end

command.Run = function(main,user,...)
	if (user == nil) then error("No user found") end
	local reason = game:GetService("Chat"):FilterStringForBroadcast(table.concat({...}," "),user)
	
	local players = game:GetService("Players")
	isClosed = true
	sdReason = reason
	for _,player in pairs(players:GetPlayers()) do
		player:Kick("SERVER SHUTTING DOWN\n\n" .. reason)
	end
end

return command
