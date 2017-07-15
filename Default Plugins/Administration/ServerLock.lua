--[[
	  ____                      _       _           _       
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/                                                                                         
	               
	@Description: SyncAdmin plugin command to lock your game server to prevent other users from joining.
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
--]]

local command = {}
command.PermissionLevel = 1
command.Shorthand = {"slock","sl"}
command.Params = {"Boolean","..."}
command.Usage = "serverlock true/false reason"
command.Description = [[Locks and unlocks the server.]] 

local locked = false
local reason = ""
command.Init = function(main)
	local players = game:GetService("Players")
	players.PlayerAdded:connect(function(p)
		wait(1)
		if locked == true then
			if (SyncAPI.GetPermissionLevel(p) <= 0) then
				if (reason == "") then
					p:Kick("The server is locked")
				else
					p:Kick("The server is locked for reason: " .. reason)
				end
			end
		end
	end)
end

command.Run = function(main,user,lock,...)
	reason = game:GetService("Chat"):FilterStringForBroadcast(table.concat({...}," "),user)
	locked = lock
	
	local players = game:getService("Players")
	for _,p in pairs(players:GetPlayers()) do
		local message = "The server has been " .. (lock and "locked" or "unlocked") .. (reason == "" and "" or " for reason: " .. reason)
		SyncAPI.DisplayNotification(p,message,"Check",10)
	end
	
	return true,(lock and "Locked" or "Unlocked") .. " the server"
end

return command
