--[[
			  ____                      _       _           _       
			 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
			 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
			  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
			 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
			        |___/                                                                                         
                           
			@Description: Synchronized Admin Commands | Verified Plugin Command
			@Author: Skeletonarcher12
			
]]

local command = {}
command.PermissionLevel = 1
command.Shorthand = "cdown"
command.Params = {"Number","..."}
command.Usage = "countdown Number Message"
command.Description = [[Uses the notification bar to do a countdown. Also includes a customisable
message at the start to tell people about the countdown.]] 

command.Init = function(main)
end

command.Run = function(main,user,number,...)
	local timeleft = table.concat({number}," ")
	local msg = game:GetService("Chat"):FilterStringForBroadcast(table.concat({...}," "),user)
	local players = game:getService("Players")
	
	for _,p in pairs(players:GetPlayers()) do
		SyncAPI.DisplayMessage(p,"Countdown!",msg,"Exclamation")
	end
	
	while number >= 1 do
		local players = game:getService("Players")
		for _,p in pairs(players:GetPlayers()) do
			SyncAPI.DisplayNotification(p,number,"Exclamation",3)
		end
		number = number - 1
		local msg = table.concat({number}," ")
		wait(1)
	end
	
	for _,p in pairs(players:GetPlayers()) do
		SyncAPI.DisplayMessage(p,"Done!","","Check")
	end
end

return command