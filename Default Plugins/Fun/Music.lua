--[[
	  ____                      _       _           _       
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/                                                                                         
	               
	@Description: SyncAdmin plugin command to play music for the entire game.
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
--]]

local command = {}
command.PermissionLevel = 1
command.Shorthand = {"play","audio","sound"}
command.Params = {"Number"}
command.Usage = "music SoundID"
command.Description = [[Plays the given SoundID.]] 

function strSplit(inputstr,sep)
	local t,i = {},1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

command.Init = function(main)
end

command.Run = function(main,user,id)
	if (user == nil) then error("No user found") end
	
	local list1 = {}
	local list2 = {}
	spawn(function()
		local snd = workspace:findFirstChild("music")
		if (snd) then
			if (id == "stop") then
				snd:stop()
				wait(1)
				snd:Destroy()
			else
				snd:stop()
				wait(1)
				snd.SoundId = "rbxassetid://" .. id
				wait(1)
				snd:play()
			end
		elseif (id ~= "stop") then
			local snd = Instance.new("Sound")
			snd.Name = "music"
			snd.SoundId = "rbxassetid://" .. id
			snd.Looped = true
			snd.Parent = workspace
			wait(1)
			snd:play()
		end
	end)
	wait(1)
	if (id == "stop") then
		return true,"Stopped music"
	else
		return true,"Played music"
	end
end

return command