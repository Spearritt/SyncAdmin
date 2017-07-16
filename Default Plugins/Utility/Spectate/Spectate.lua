--[[
	  ____                      _       _           _       
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/                                                                                         
	               
	@Description: SyncAdmin plugin command to spectate another player.
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
--]]

local command = {}
command.PermissionLevel = 1
command.Shorthand = "spec"
command.Params = {"Player"}
command.Usage = "spectate Player"
command.Description = [[Makes your camera follow them instead of you.]] 

command.Init = function(main)
end

command.Run = function(main,user,target)
	if (target and target.Character) then
		local hum = target.Character:findFirstChild("Humanoid")
		if (hum) then
			local sscript = script.SA_Spectate:clone()
			sscript.Target.Value = hum
			sscript.Disabled = false
			sscript.Parent = user.Character
			return true,"Now spectating " .. target.Name
		end
	end
	return false,"Cannot spectate " .. target.Name .. "; no character."
end

return command
